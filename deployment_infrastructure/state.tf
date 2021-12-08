terraform {
 backend "s3" {
   bucket         = "infra-s3-state-35"
   key            = "state/terraform.tfstate"
   region         = "us-east-2"
   encrypt        = true
   kms_key_id     = "alias/terraform-infra-bucket-key-35"
   dynamodb_table = "terraform-infra-state-35"
 }
}   
