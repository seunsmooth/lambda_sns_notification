variable aws_region {
  default = "eu-west-1"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "aws region"
}

variable "sns_topic_name" {
  type        = string
  default     = "sns_mycompany_topic"
  description = "sns topic name"
}

variable "sns_subscription_email_address_list" {
  type        = string
  default     = "seunsmooth@yahoo.com"
  description = "List of email addresses as string(space separated)"
}
