# Configure the AWS provider and set the deployment region
provider "aws" {
  region = "us-east-1"
}

# IAM role that allows Lambda to assume execution permissions
resource "aws_iam_role" "lambda_role" {
  name = "lambda_exec_role"

  # Trust policy granting Lambda service permission to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# Attach AWS managed policy to allow Lambda to write logs to CloudWatch
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Package the Lambda source file into a zip archive for deployment
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

# Lambda function definition using the zipped deployment package
resource "aws_lambda_function" "my_lambda" {
  function_name    = "my_lambda_function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.handler"  # file.function format
  runtime          = "python3.12"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256  # triggers redeployment on code change
}

# HTTP API Gateway that acts as the trigger for the Lambda function
# 'target' creates a default route ($default) and integration automatically
resource "aws_apigatewayv2_api" "http_api" {
  name          = "my_http_api"
  protocol_type = "HTTP"
  target        = aws_lambda_function.my_lambda.arn
}

# Grant API Gateway permission to invoke the Lambda function
resource "aws_lambda_permission" "apigw" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"  # allows all methods and routes
}

# Output the API Gateway endpoint URL after deployment
output "api_endpoint" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}
