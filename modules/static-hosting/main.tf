variable "domain_name" {
  default = ""
}

variable "tags" {
  default = ""
}

resource "aws_s3_bucket" "static-hosting" {
  bucket = var.domain_name
  acl    = "public-read"
  /*lifecycle {
    ignore_changes = [
      #"grant.0.%"

    ]
  }*/
  website {
    index_document = "index.html"
    error_document = "index.html"

  }
  tags = var.tags
}

resource "aws_s3_bucket_policy" "b" {
  bucket = "${aws_s3_bucket.static-hosting.id}"
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      policy
    ]
  }
  policy = <<POLICY
{
      "Version": "2008-10-17",
      "Id": "publicGetAndList",
      "Statement": [
          {
              "Sid": "get",
              "Effect": "Allow",
              "Principal": "*",
              "Action": "s3:GetObject",
              "Resource": "${aws_s3_bucket.static-hosting.arn}/*"
          },
          {
              "Sid": "list",
              "Effect": "Allow",
              "Principal": "*",
              "Action": "s3:ListBucket",
              "Resource":"${aws_s3_bucket.static-hosting.arn}"
          }
      ]
}
POLICY

}



output "bucket_name" {
  value = "${aws_s3_bucket.static-hosting.id}"
}
