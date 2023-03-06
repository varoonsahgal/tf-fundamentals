#!/bin/bash

export TF_VAR_pgp_key=$(gpg --export "Allen Sanders" | base64)
terraform init
terraform $@
