provider "aws" {
  version    = "~> 3.0"
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# VARIABLES

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  default = "ap-southeast-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-assignment-state-bucket"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  hash_key     = "LockID"
  name         = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}
