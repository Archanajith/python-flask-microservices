terraform {
 backend "s3" {
   bucket         = "infra-s3-state-34"
   key            = "state/terraform.tfstate"
   region         = "us-east-2"
   encrypt        = true
   kms_key_id     = "alias/terraform-infra-bucket-key-34"
   dynamodb_table = "terraform-infra-state-34"
 }
}   
