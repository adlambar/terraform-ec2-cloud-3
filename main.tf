provider "aws" {
  region = var.region
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

resource "aws_instance" "ubuntu" {
  #ami           = data.aws_ami.ubuntu.id
  ami = "ami-052efd3df9dad4825"
  instance_type = var.instance_type
  key_name = "ec2_keypair"
  vpc_security_group_ids = [aws_security_group.instances.id]
  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "instances" {
  name = "instance-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}