resource "aws_default_vpc" "rabbitMQ" {
 tags = {
   Name = "test_rabbit_mq"
 }
}

data "aws_vpc" "rabbitMQ_data" {
  filter {
    name = "tag:Name"
    values = ["test_rabbit_mq"]
  }
}


resource "aws_security_group" "demo-sg" {
  name = "sec-grp"
  vpc_id = data.aws_vpc.rabbitMQ_data.id
  description = "Allow HTTP and SSH traffic via Terraform"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
