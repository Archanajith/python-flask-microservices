#KMS For encription of s3

provider "aws" {
region = var.aws_region
}
resource "aws_kms_key" "terraform-synthetic-s3-key-46" {
 description             = "This key is used to encrypt bucket objects"
 deletion_window_in_days = 10
 enable_key_rotation     = true
}

resource "aws_kms_alias" "terraform-synthetic-key-alias" {
 name          = "alias/terraform-synthetic-s3-key-46"
 target_key_id = aws_kms_key.terraform-synthetic-s3-key-46.key_id
}

resource "aws_s3_bucket" "terraform-synthetic-state-s3-46" {
 bucket = var.s3_bucket
 acl    = "private"

 versioning {
   enabled = true
 }

 server_side_encryption_configuration {
   rule {
     apply_server_side_encryption_by_default {
       kms_master_key_id = aws_kms_key.terraform-synthetic-s3-key-46.arn
       sse_algorithm     = "aws:kms"
     }
   }
 }
}

resource "aws_s3_bucket_public_access_block" "block" {
 bucket = aws_s3_bucket.terraform-synthetic-state-s3-46.id

 block_public_acls       = true
 block_public_policy     = true
 ignore_public_acls      = true
 restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform-dashboard-state-dyn" {
 name           = var.dynamo_db_table
 read_capacity  = 20
 write_capacity = 20
 hash_key       = "LockID"

 attribute {
   name = "LockID"
   type = "S"
 }
}
