terraform {
  required_providers {
    # https://registry.terraform.io/providers/hashicorp/aws/latest/docs
    aws = {
        source = "hashicorp/aws"
        version = "6.44.0"
    }
  }
}

provider "aws" {

}