/*
terraform {
  backend "s3" {
    bucket = "my-terraform-assignment-state-bucket"
    key    = "global/s3/terraform.tfstate"
    region = "ap-southeast-1"
    dynamodb_table = "terraform-state-locking"
    encrypt = true
  }
}
*/
