terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_s3_bucket" "bucket" {
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key = "myfile.txt"
  source = "myfile.txt"
  
  etag = filemd5("myfile.txt")
}