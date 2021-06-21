terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "jukin-statefile"
    key = "jukin-terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "s3-state-lock"
    access_key = secrets.AWS_ACCESS_KEY_ID
    secret_key = secrets.AWS_SECRET_ACCESS_KEY
    
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda-1" {
  function_name = "first_test"
  role          = aws_iam_role.iam_for_lambda.arn

  runtime = "java 1.8"

  handler = ""
}
