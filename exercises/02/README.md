# Exercise #2: Using Variables

## Goals
* Understand the *four* different ways to declare variables in terraform

### Let's look at our `variables.tf` file...

```hcl
# Declare a variable so we can use it.
variable "student_alias" {
  type        = string
  description = "Your student alias"
  validation {
    condition     = trimprefix(var.student_alias, "test") == var.student_alias
    error_message = "Please do not use test aliases with this deployment."
  }
}
```

* (BTW, what's the name of our variable?)


### What is the value of this variable?

* There is no "value" parameter in the syntax for the variable object
* Variable stanzas are not meant to be inputs, but rather placeholders for input that can be references in our Terraform code
* Variable stanzas can be used this way by simply setting the `default` to the desired value
* But this negates the benefits of Terraform's native re-usability, instead try...


### Let's get started

```bash
terraform init
```

The init should have picked up on the fact that we had a reference to AWS resources in our HCL. Namely, that we defined the AWS provider

```hcl
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
```

### What are the 4 ways we can set our variables?

### 1) The `.tfvars` file

In each terraform working directory, there can be a file named `terraform.tfvars` (or `*.auto.tfvars`) containing
HCL that defines values for variables for that working directory.

Let's try a few things:

1. Create a file called `terraform.tfvars` in this directory
1. Insert the following code into it:
```hcl
# swap "[your alias]" with your provided alias
student_alias = "[your alias]"
```
1. Then run this in the same directory
```bash
terraform plan
```

 * You should see that the terraform plan output includes an s3 bucket, and that the value for `bucket_name`
 utilizes your chosen identifying text
<br/><br/>
1. Remove your `terraform.tfvars` file so we can look at other ways of passing in the variable:

 ```
 rm terraform.tfvars
 ```

### 2) Command Line Arguments

Another method you can use is to insert variables via the CLI.  This allows for quick variable substitution and
testing because values entered via CLI override values from other methods.

1. Run the following in this working directory (if you were able to complete the previous), swapping for your
identifier like before.

 ```bash
 terraform plan -var 'student_alias=[your alias]'
 ```

 (You can try using a different identifier to see if it worked–as before, you should be able to see the
new identifier in the plan output)

### 3) Using Environment variables

Environment variables can be used to set the value of an input variable=. The name of the variable must be `TF_VAR_` followed by the variable name, and the value is the value of the variable.

1. Try the following:

 ```bash
 TF_VAR_student_alias=[your alias] terraform plan
 ```

 (This can be a useful method for secrets handling, or other automated use cases)

### 4) Prompt for a variable value

Try just running the plan without having a pre-populated value set:

```
terraform plan
```

### 5) Adjust validation

1. Adjust the validation defined for the `student_alias` variable to also enforce a minimum length of 5 characters and a maximum length of 20 characters. You might find https://www.terraform.io/docs/language/functions/index.html helpful for info on built-in functions. Update the error message to reflect all validation rules.

1. Test `terraform plan` with values for the variable that satisfy the validation and that fail the validation.
