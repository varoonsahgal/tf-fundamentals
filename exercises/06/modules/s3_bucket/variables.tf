# variables.tf

# Declare a variable so we can use it.
variable "region" {
  default = "us-west-2"
  type    = string
}

variable "student_alias" {
  type        = string
  description = "Your student alias"
}
