#KMS For encription of s3
provider "aws" {
  region = "${var.region}"
  
}

resource "aws_kms_key" "terraform-infras-bucket-key-101" {
 description             = "This key is used to encrypt bucket object"
 deletion_window_in_days = 10
 enable_key_rotation     = true
}

resource "aws_kms_alias" "terraform-infra-key-alias" {
 name          = "alias/terraform-infras-bucket-key-101"
 target_key_id = aws_kms_key.terraform-infras-bucket-key-101.key_id
}

resource "aws_s33_bucket" "terraform-infras-state-final" {
 bucket = "infras-s33-state-final"
 acl    = "private"

 versioning {
   enabled = true
 }

 server_side_encryption_configuration {
   rule {
     apply_server_side_encryption_by_default {
       kms_master_key_id = aws_kms_key.terraform-infras-bucket-key-101.arn
       sse_algorithm     = "aws:kms"
     }
   }
 }
}

resource "aws_s3_bucket_public_access_block" "block-infra" {
 bucket = aws_s33_bucket.terraform-infras-state-final.id

 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform-infras-state-final" {
 name           = "terraform-infras-state-final"
 read_capacity  = 20
 write_capacity = 20
 hash_key       = "LockID"

 attribute {
   name = "LockID"
   type = "S"
 }
}
