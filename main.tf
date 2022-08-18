provider "aws" {
  region = var.region
}

data "aws_security_groups" "sgs" {
  filter {
    name   = "group-name"
    values = [var.instance_sgs]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "instance" {
  #ami                      = data.aws_ami.ubuntu.id
  ami                       = var.instance_ami
  instance_type             = var.instance_type
  key_name                  = "ec2_keypair"
  vpc_security_group_ids    = [data.aws_security_groups.sgs.ids]
  user_data                 = file(var.instance_user_data)
  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "instances" {
  name = "instance-sg-3"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
