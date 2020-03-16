provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_security_group" "allow_http_and_hello_world" {
  name        = "allow_http_and_hello_world"
  description = "Allow only default http and 8000"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For hello world http server"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "hello-world" {
    ami           = "ami-0f02b24005e4aec36"
    instance_type = "t2.micro"
    security_groups = ["${aws_security_group.allow_http_and_hello_world.name}"]
    user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y python
echo "This is fine"
echo "https://${aws_s3_bucket.demo_bucket.bucket_regional_domain_name}/${aws_s3_bucket_object.demo_image.id}"
echo 'Hello, World
<img src="https://${aws_s3_bucket.demo_bucket.bucket_regional_domain_name}/${aws_s3_bucket_object.demo_image.id}" alt="Demo Picture">' > index.html
python -m SimpleHTTPServer 8000
    EOF
}
