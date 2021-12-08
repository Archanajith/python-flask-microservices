terraform {
 backend "s3" {
   bucket         = "synthetic-s3-state-46"
   key            = "state/terraform.tfstate"
   region         = "us-east-2"
   encrypt        = true
   kms_key_id     = "alias/terraform-synthetic-s3-key-46"
   dynamodb_table = "terraform-synthetic-state-46"
 }
}   
