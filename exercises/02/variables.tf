# variables.tf

# Declare a variable so we can use it.
variable "student_alias" {
  type        = string
  description = "Your student alias"
  validation {
    condition     = trimprefix(var.student_alias, "test") == var.student_alias
    error_message = "Please do not use test aliases with this deployment."
  }
}
