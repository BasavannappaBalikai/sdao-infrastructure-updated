variable "tags" {
  default = ""
}

variable "acl" {
  default = ""
}

variable "bucket_name" {
  default = ""
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = var.acl
  tags   = var.tags
  lifecycle {
    ignore_changes = [
      acl,
      force_destroy,
      grant
    ]
  }
}

output "bucket_name" {
  value = "${aws_s3_bucket.bucket.id}"
}

