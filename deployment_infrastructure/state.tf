terraform {
 backend "s3" {
   bucket         = "infra-s3-state-55"
   key            = "state/terraform.tfstate"
   region         = "us-east-1"
   encrypt        = true
   kms_key_id     = "alias/terraform-infras-bucket-key-101"
   dynamodb_table = "terraform-infra-state-55"
 }
}   
