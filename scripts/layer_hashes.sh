#!/usr/bin/env bash
# Terraform external data source wrapper: builds the layer zips (if stale)
# at plan time, then emits their hashes as JSON. This keeps the files
# stable between plan and apply, unlike a local-exec provisioner.
set -euo pipefail

cd "$(dirname "$0")/.."

bash scripts/make_layer_zip.sh >&2

md5_of()    { openssl md5 -r "$1" | cut -d' ' -f1; }
sha256_of() { openssl dgst -sha256 -binary "$1" | base64; }

cat <<EOF
{
  "layer_01_md5": "$(md5_of layer_01.zip)",
  "layer_01_sha256": "$(sha256_of layer_01.zip)",
  "layer_02_md5": "$(md5_of layer_02.zip)",
  "layer_02_sha256": "$(sha256_of layer_02.zip)"
}
EOF
