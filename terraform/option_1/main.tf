provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "example" {
  filename      = "../../option_1.zip"
  function_name = "example"
  role          = aws_iam_role.example.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
}

resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.example.name
}

resource "aws_lambda_function_url" "example" {
  function_name      = aws_lambda_function.example.function_name
  authorization_type = "NONE"
}

output "lambda_url" {
  value = aws_lambda_function_url.example.function_url
}