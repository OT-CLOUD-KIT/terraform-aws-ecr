terraform {
  backend "s3" {
    bucket = "ot-cloud-kit-bucket"
    key    = "ot/module/ECR/terraform.tfstate"
    region = "us-east-1"

  }
}