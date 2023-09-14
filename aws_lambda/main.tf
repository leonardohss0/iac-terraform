# Create an AWS Lambda function
resource "aws_lambda_function" "example_lambda" {
  function_name = "demo-process-data-firehose-terraform" # Replace with your desired function name
  runtime       = "python3.8"                            # Set the runtime to Python 3.8

  # Replace this with the path to your Lambda function code
  filename = "demo-process-data-firehose.zip"

  handler     = "index.handler" # Replace with your handler function
  memory_size = 256             # Replace with your desired memory size in MB
  timeout     = 10              # Replace with your desired timeout in seconds

  # IAM role for the Lambda function
  role = aws_iam_role.lambda_execution_role.arn

  # Environment variables for your Lambda function (optional)
  environment {
    variables = {
      ENV_VAR_NAME = "example-value"
    }
  }

  # Attach the AWS Lambda Layer by ARN
  layers = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python38:9"]
}

# IAM role for the Lambda function
resource "aws_iam_role" "lambda_execution_role" {
  name = "example-lambda-role" # Replace with your desired role name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM policy for the Lambda function to access other AWS services (e.g., S3, CloudWatch, etc.)
resource "aws_iam_policy" "lambda_policy" {
  name = "example-lambda-policy" # Replace with your desired policy name

  # Define the permissions your Lambda function needs
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "lambda:GetFunctionConfiguration",
          "lambda:InvokeFunction",
          "s3:*",
          "s3-object-lambda:*"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

# Attach the IAM policy to the Lambda function's IAM role
resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "example-lambda-policy-attachment" # Provide a unique name for the attachment
  policy_arn = aws_iam_policy.lambda_policy.arn
  roles      = [aws_iam_role.lambda_execution_role.name]
}