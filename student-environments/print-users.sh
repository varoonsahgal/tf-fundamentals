#!/bin/bash

values=$(terraform output -json)

let i=0
for username in $(echo $values | jq -r '.students.value[].name'); do
  for loop in 1; do
	echo "Console URL:           https://tf-intro.signin.aws.amazon.com/console"
	echo "Username/Alias:        $username"
	password=$(echo $values | jq -r '.passwords.value[]['"$i"']' | base64 --decode | gpg -dq)
	echo "AWS Console Password:  $password"
	access_key=$(echo $values | jq -r '.test_access_keys.value[]['"$i"']')
	echo "AWS Access Key: $access_key"
	secret_key=$(echo $values | jq -r '.test_secret_keys.value[]['"$i"']')
	echo "AWS Secret Key: $secret_key"
	region=$(echo $values | jq -r '.students.value['"$i"'].region')
	echo "Exercise 11 Region:    $region"
	echo "Link to the slides:    https://github.com/KernelGamut32/terraform-fundamentals-public/blob/main/Slide%20Decks/Terraform%20Fundamentals.pdf"
	echo "Instructor email:      asanders@gamuttechnologysvcs.com"
	echo ""
	echo ""
	echo ""
	let i=i+1
  done > tf-user$i
done
