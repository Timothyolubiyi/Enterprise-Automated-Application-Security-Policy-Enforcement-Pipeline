terraform {
  backend "s3" {
    bucket = "enterprise-devsecops-tfstate"
    key    = "terraform/state.tfstate"
    region = "eu-north-1"

    use_lockfile = true
    encrypt      = true
  }
}