#-----------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#
# Made by Dmytro Rudenko
#-----------------------------------------


provider "aws" {
  region     = "eu-central-1"
  access_key = ....
  secret_key = ....
}

terraform {
  required_version = ">= 0.12"
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0cc0a36f626a4fdf5"
  key_name               = aws_key_pair.webserver_key.key_name
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.my_webserver.id}"]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Dmytro",
    l_name = "Rudenko",
    names  = ["aws", "werv"]
  })

  tags = {
    Name  = "WebServer Build by Terraform"
    Owner = "Dmytro Rudenko"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer Security Group"
    Owner = "Dmytro Rudenko"
  }
}
