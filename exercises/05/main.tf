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
# Provider supports setting things like target region.
# It can also pull credentials and the region to use from environment variables, which we have set, so we'll use those
provider "aws" {
}

# declare a resource stanza so we can create something.
resource "aws_s3_bucket" "student_bucket_alt" {
  bucket  = "devint-${var.student_alias}-alt"
}
