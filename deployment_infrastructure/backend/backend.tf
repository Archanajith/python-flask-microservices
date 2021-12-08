#KMS For encription of s3
provider "aws" {
  region = "us-east-1"
  
}

resource "aws_kms_key" "terraform-infra-bucket-key-3" {
 description             = "This key is used to encrypt bucket object"
 deletion_window_in_days = 10
 enable_key_rotation     = true
}

resource "aws_kms_alias" "terraform-infra-key-alias" {
 name          = "alias/terraform-infra-bucket-key-3"
 target_key_id = aws_kms_key.terraform-infra-bucket-key-3.key_id
}

resource "aws_s3_bucket" "terraform-infra-state-2" {
 bucket = "infra-s3-state-2"
 acl    = "private"

 versioning {
   enabled = true
 }

 server_side_encryption_configuration {
   rule {
     apply_server_side_encryption_by_default {
       kms_master_key_id = aws_kms_key.terraform-infra-bucket-key-3.arn
       sse_algorithm     = "aws:kms"
     }
   }
 }
}

resource "aws_s3_bucket_public_access_block" "block-infra" {
 bucket = aws_s3_bucket.terraform-infra-state-2.id

 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform-infra-state-2" {
 name           = "terraform-infra-state-2"
 read_capacity  = 20
 write_capacity = 20
 hash_key       = "LockID"

 attribute {
   name = "LockID"
   type = "S"
 }
}
