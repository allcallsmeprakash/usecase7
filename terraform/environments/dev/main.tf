terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
module "lambda" {
  source      = "../../modules/iam-lambda"
  lambda_name = var.lambda_name
  image_uri   = var.image_uri
}

module "apigateway" {
  source             = "../../modules/api_gateway"
  api_name           = var.api_name
  region             = var.aws_region
  lambda_invoke_arn  = module.lambda.lambda_arn
  lambda_name        = module.lambda.lambda_name
  stage_name         = var.stage_name
}
