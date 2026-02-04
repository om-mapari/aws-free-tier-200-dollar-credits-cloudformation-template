variable "email_address" {
  description = "Email address for budget and billing alerts"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.email_address))
    error_message = "Must be a valid email address."
  }
}

variable "budget_amount" {
  description = "Monthly budget amount in USD (minimum $1)"
  type        = number
  default     = 1

  validation {
    condition     = var.budget_amount >= 1
    error_message = "Budget amount must be at least $1."
  }
}

variable "billing_alarm_threshold" {
  description = "Billing alarm threshold in USD (can be less than $1)"
  type        = number
  default     = 0.1
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}
