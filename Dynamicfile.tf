#-----------------------------------------
# My Terraform
#
# Build WebServer during Bootstrap
#
# Made by Dmytro Rudenko
#-----------------------------------------


provider "aws" {
  region     = "eu-central-1"
  access_key = "AKIAS4HD3Q443GARDFO2"
  secret_key = "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"
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
    names  = ["vasya", "kolya", "Petya", ]
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

resource "aws_key_pair" "webserver_key" {
  key_name   = "id_rsa_pub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQvBxjSIxYxECFrdQ8GZR8Ki8cZGa/TX7Dz9RnNVEEVnzfAy19qAiG1bBB28aeXhv2lt9FxlZ1cJpOsqqBlH9Me3V6lx8IYS/hmtWYS4YlcGMN5ZVmsFfZ7+ZZhFN1FXWTFL6dv6SGUZwurUup8w+9C2ooQ6ic5xrenciyE6OGhOq6x6gn0JSY0xYFry49ZrQLcMMNBPaJqpkQ1N4tixvOK/oNLSTOC3B6BkYqbqeVpTMniMpwh51ESBIrb7Ei5v8NLEE4aQ/SX/GAsD52eExRN/6fjCNYigIu0o3/IpPLNAtm2YKPbvk35QkMNdSnWUtN1AeBGWtqtx9btPwJJvz9 awserv@imit"
}


resource "aws_key_pair" "webserver_key2" {
  key_name   = "id_rsa2_pub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf6BqRBce3Hypd/RD7XaYBW1/g4dpnGxo4C3n0DhQ3SHJTRuvkl5BtfNVu6jZnIE0RcSVGoO1SYzleGtwdFro2A/TSyr/b4KvtJIwFk2otHwBycPXrMNRi6kPDHPOAGpiNuASchzGDOAEF8d3SlROk8VgsPdhDj3+oLOJgWjtOjz5Mq0Hw3bja7OuB91DM9L2qzdi/0T0o4+BgGE1jDwmIF7hQrPr2SF8VaPoZVjwiGtPhuW973Ach4gJE7dX/dduQ/hkH1L8IWKWAnScHctSWPZml+CsRq5cWIVS8QrA/yN7weHCjCPRRECGK484C/nEvw7duqcs1OWNbQy8lWB+t awserv@imit"
}
