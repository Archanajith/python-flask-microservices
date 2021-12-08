terraform {
 backend "s3" {
   bucket         = "monitor-s3-state-44"
   key            = "state/terraform.tfstate"
   region         = "us-east-2"
   encrypt        = true
   kms_key_id     = "alias/terraform-monitor-bucket-key-44"
   dynamodb_table = "terraform-monitor-state-44"
 }
}   
