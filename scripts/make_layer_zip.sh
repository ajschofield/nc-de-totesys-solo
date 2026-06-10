#!/usr/bin/env bash
# Build the Lambda layer zips from the lambda-layer-* dependency groups
# in pyproject.toml. Wheels are resolved for the Lambda runtime platform,
# not the host machine, so this works from macOS too.
set -euo pipefail

cd "$(dirname "$0")/.."

PY_VERSION=3.13
SITE_PACKAGES="python/lib/python${PY_VERSION}/site-packages"

# A zip is fresh if it exists and none of its inputs are newer than it
layer_is_fresh() {
  local zip=$1
  [ -f "$zip" ] || return 1
  [ -z "$(find pyproject.toml uv.lock scripts/make_layer_zip.sh -newer "$zip" 2>/dev/null)" ]
}

build_layer() {
  local group=$1 zip_name=$2
  local reqs
  reqs=$(mktemp)

  if layer_is_fresh "$zip_name"; then
    echo "$zip_name is up to date, skipping" >&2
    return 0
  fi

  rm -rf python "$zip_name"
  mkdir -p "$SITE_PACKAGES"

  uv export --only-group "$group" --no-emit-project --no-hashes -o "$reqs"
  uv pip install -r "$reqs" \
    --target "$SITE_PACKAGES" \
    --python-version "$PY_VERSION" \
    --python-platform x86_64-manylinux_2_28 \
    --only-binary :all:

  # Trim runtime-irrelevant files to stay under Lambda's 250MB unzipped limit
  find python -type d \( -name "__pycache__" -o -name "tests" \) -prune -exec rm -rf {} +
  rm -rf "$SITE_PACKAGES"/bin "$SITE_PACKAGES"/include "$SITE_PACKAGES"/pyarrow/include

  zip -rq "$zip_name" python
  rm -rf python "$reqs"
}

build_layer lambda-layer-01 layer_01.zip
build_layer lambda-layer-02 layer_02.zip
