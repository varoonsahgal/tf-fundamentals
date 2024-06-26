# S3 backend example 
# see https://www.terraform.io/docs/backends/types/s3.html

# Run this from your own machine as well as from your Cloud9 IDE
# and you'll see that state is maintained across both machines.

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0.0"
    }
  }
  backend "s3" {
    bucket = "devint-* # change '*' to your student alias and add trailing quote
    key    = "state/remote-state"
	  region = "us-west-2"
  }
}

provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "TestInstance"
  }
}
