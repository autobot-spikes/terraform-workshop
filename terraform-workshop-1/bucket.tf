resource "aws_s3_bucket" "demo_bucket" {
  bucket = "autobot-demo-bucket"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "demo_image" {
  bucket = "${aws_s3_bucket.demo_bucket.id}"
  key    = "demo-image.png"
  source = "demo-image.png"
  acl = "public-read"

  force_destroy = true
}
