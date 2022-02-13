resource "aws_lambda_function" "app" {
  function_name = var.project_name
  image_uri     = "${aws_ecr_repository.app.repository_url}:${var.tag_daploy}"
  package_type  = "Image"
  role          = aws_iam_role.lambda.arn
  memory_size   = 512
  timeout       = 30
  environment {
    variables = {
      PLAYWRIGHT_BROWSERS_PATH = "/playwright/bin"
    }
  }
}
resource "aws_iam_role" "lambda" {
  path = "/service-role/"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    aws_iam_policy.lambda.arn,
  ]
}
resource "aws_iam_policy" "lambda" {
  path = "/service-role/"
  policy = jsonencode(
    {
      Statement = [
        {
          Action   = "logs:CreateLogGroup"
          Effect   = "Allow"
          Resource = "arn:aws:logs:${var.region}:${data.aws_caller_identity.self.account_id}:*"
        },
        {
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
          ]
          Effect = "Allow"
          Resource = [
            "arn:aws:logs:${var.region}:${data.aws_caller_identity.self.account_id}:log-group:/aws/lambda/${var.project_name}:*",
          ]
        },
      ]
      Version = "2012-10-17"
    }
  )
}
