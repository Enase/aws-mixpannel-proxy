terraform {
  required_version = "~> 1.10.5"

	backend "s3" {
      bucket = "your-terraform-deploy-bucket"
      key    = "state/mixpanel/terraform.tfstate"
      region = "us-west-2"
      encrypt = true
      dynamodb_table = "terraform-state-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.86"
    }
  }
}
