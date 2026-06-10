####################
# Common Variables #
####################

locals {
  layer_dir         = "../"
  layer_zip_01      = "layer_01.zip"
  layer_zip_02      = "layer_02.zip"
  layer_name_01     = "lambda_layer_01"
  layer_name_02     = "lambda_layer_02"
  script_dir        = "../scripts"
  layer_zip_01_path = "${local.layer_dir}${local.layer_zip_01}"
  layer_zip_02_path = "${local.layer_dir}${local.layer_zip_02}"
}

# Builds the layer zips at plan time (skipped when already up to date) and
# returns their hashes, so the files don't change between plan and apply.
data "external" "lambda_layers" {
  program = ["bash", "${local.script_dir}/layer_hashes.sh"]
}

################################
# Lambda Layer (Extract) Setup #
################################
resource "aws_s3_object" "lambda_layer_zip_01" {
  bucket        = aws_s3_bucket.lambda_code_bucket.id #bucket instead of id
  key           = "${local.layer_name_01}/${local.layer_zip_01}"
  source        = "${local.layer_dir}${local.layer_zip_01}"
  source_hash   = data.external.lambda_layers.result.layer_01_md5
  force_destroy = true
}

resource "aws_lambda_layer_version" "lambda_layer_01" {
  layer_name          = local.layer_name_01
  compatible_runtimes = ["python3.13"]
  s3_bucket           = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key              = aws_s3_object.lambda_layer_zip_01.key
  source_code_hash    = data.external.lambda_layers.result.layer_01_sha256
  depends_on          = [aws_s3_object.lambda_layer_zip_01]
}

#########################################
# Lambda Layer (Load & Transform) Setup #
#########################################
resource "aws_s3_object" "lambda_layer_zip_02" {
  bucket        = aws_s3_bucket.lambda_code_bucket.id #bucket instead of id
  key           = "${local.layer_name_02}/${local.layer_zip_02}"
  source        = "${local.layer_dir}${local.layer_zip_02}"
  source_hash   = data.external.lambda_layers.result.layer_02_md5
  force_destroy = true
}

resource "aws_lambda_layer_version" "lambda_layer_02" {
  layer_name          = local.layer_name_02
  compatible_runtimes = ["python3.13"]
  s3_bucket           = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key              = aws_s3_object.lambda_layer_zip_02.key
  source_code_hash    = data.external.lambda_layers.result.layer_02_sha256
  depends_on          = [aws_s3_object.lambda_layer_zip_02]
}

###########################
# Extract Lambda Function #
###########################

data "archive_file" "extract_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../src/extract_lambda.py"
  output_path = "${path.module}/../extract_function.zip"
}
resource "aws_s3_object" "extract_lambda_code" {
  bucket = aws_s3_bucket.lambda_code_bucket.bucket
  key    = "${var.extract_lambda_name}/extract_function.zip"
  source = data.archive_file.extract_lambda_zip.output_path
  etag   = filemd5(data.archive_file.extract_lambda_zip.output_path)
}

resource "aws_lambda_function" "extract_lambda" {
  function_name    = var.extract_lambda_name
  s3_bucket        = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key           = aws_s3_object.extract_lambda_code.key
  layers           = [aws_lambda_layer_version.lambda_layer_01.arn]
  role             = aws_iam_role.multi_service_role.arn
  handler          = "extract_lambda.lambda_handler"
  runtime          = "python3.13"
  source_code_hash = data.archive_file.extract_lambda_zip.output_base64sha256
  timeout          = 180

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_s3_object.extract_lambda_code]
}

#############################
# Transform Lambda Function #
#############################


data "archive_file" "transform_lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../src/transform_lambda"
  output_path = "${path.module}/../transform_lambda.zip"
}

resource "aws_s3_object" "transform_lambda_code" {
  bucket = aws_s3_bucket.lambda_code_bucket.bucket
  key    = "${var.transform_lambda_name}/transform_function.zip"
  source = data.archive_file.transform_lambda_zip.output_path
  etag   = filemd5(data.archive_file.transform_lambda_zip.output_path)
}

resource "aws_lambda_function" "transform_lambda" {
  function_name    = var.transform_lambda_name
  s3_bucket        = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key           = aws_s3_object.transform_lambda_code.key
  layers           = [aws_lambda_layer_version.lambda_layer_02.arn]
  role             = aws_iam_role.multi_service_role.arn
  handler          = "transform_lambda.lambda_handler"
  runtime          = "python3.13"
  source_code_hash = data.archive_file.transform_lambda_zip.output_base64sha256
  timeout          = 180

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_s3_object.transform_lambda_code]
}

########################
# Load Lambda Function #
########################

data "archive_file" "load_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../src/load_lambda.py"
  output_path = "${path.module}/../load_function.zip"
}
resource "aws_s3_object" "load_lambda_code" {
  bucket = aws_s3_bucket.lambda_code_bucket.bucket
  key    = "${var.load_lambda_name}/load_function.zip"
  source = data.archive_file.load_lambda_zip.output_path
  etag   = filemd5(data.archive_file.load_lambda_zip.output_path)
}

resource "aws_lambda_function" "load_lambda" {
  function_name    = var.load_lambda_name
  s3_bucket        = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key           = aws_s3_object.load_lambda_code.key
  layers           = [aws_lambda_layer_version.lambda_layer_02.arn]
  role             = aws_iam_role.multi_service_role.arn
  handler          = "load_lambda.lambda_handler"
  runtime          = "python3.13"
  source_code_hash = data.archive_file.load_lambda_zip.output_base64sha256
  timeout          = 180

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_s3_object.load_lambda_code]
}

