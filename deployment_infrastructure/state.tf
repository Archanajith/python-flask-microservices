terraform {
 backend "s3" {
   bucket         = "infras-s33-state-final"
   key            = "state/terraform.tfstate"
   region         = "us-east-1"
   encrypt        = true
   kms_key_id     = "alias/terraform-infras-bucket-key-101"
   dynamodb_table = "terraform-infras-state-final"
 }
}   
