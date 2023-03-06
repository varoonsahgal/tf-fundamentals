terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "server" {
  source = "./server"
}

resource "null_resource" "always-run-provider-script" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = module.server.instance_public_ip
      user        = "ubuntu"
      private_key = module.server.private_key
    }
    scripts = ["./provisioner.sh"]
  }
}

resource "null_resource" "spit-out-ubuntu-ami" {
  provisioner "local-exec" {
    command = "echo ubuntu AMI is ${module.server.ubuntu_ami}"
  }
}
