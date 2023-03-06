# main.tf

# Define key properties of the session.
# Allows you to define specific target version(s) of Terraform (min/max).
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0.0"
    }
  }
}

# Declare the provider being used, in this case it's AWS.
provider "aws" {
  region = var.region
}

# declare a resource stanza so we can create something.
resource "aws_s3_bucket" "user_bucket" {
  bucket_prefix = var.student_name
  versioning {
    enabled = true
  }
}

