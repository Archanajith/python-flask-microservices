variable "s3_bucket" {
  type        = string
  default     = "monitor-s3-state-45"
  description = "The s3 bucket name"
}

variable "dynamo_db_table" {
  type        = string
  default     = "terraform-monitor-state-45"
  description = "Name of dynamo db table"
}

variable "aws_region" {
    type = string
    default = "us-east-2"
    description = "aws region"
}
