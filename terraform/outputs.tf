output "extract_bucket_name" {
  value = aws_s3_bucket.extract_bucket.id
}

output "transform_bucket_name" {
  value = aws_s3_bucket.transform_bucket.id
}

output "lambda_code_bucket_name" {
  value = aws_s3_bucket.lambda_code_bucket.id
}

output "extract_lambda_arn" {
  value = aws_lambda_function.extract_lambda.arn
}

output "transform_lambda_arn" {
  value = aws_lambda_function.transform_lambda.arn
}

output "load_lambda_arn" {
  value = aws_lambda_function.load_lambda.arn
}
