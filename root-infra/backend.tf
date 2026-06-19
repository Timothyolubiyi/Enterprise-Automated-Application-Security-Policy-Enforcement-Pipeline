terraform {

  backend "s3" {

    bucket         = "enterprise-devsecops-tfstate"

    key            = "networking/terraform.tfstate"

    region         = "eu-west-1"

    dynamodb_table = "terraform-state-lock"

    encrypt        = true

  }

}