#####################################################################
##
##      Created 10/9/18 by admin. for project1
##
#####################################################################

## REFERENCE {"aws_network":{"type": "aws_reference_network"}}

terraform {
  required_version = "> 0.8.0"
}

provider "aws" {
  access_key = "${var.aws_access_id}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
  version = "~> 1.8"
}

resource "aws_instance" "aws_instance" {
  ami = "${var.aws_instance_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.aws_instance_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${aws_subnet.subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.group_name.id}"]
  tags {
    Name = "${var.aws_instance_name}"
  }
}

resource "tls_private_key" "ssh" {
    algorithm = "RSA"
}

resource "aws_key_pair" "auth" {
    key_name = "${var.aws_key_pair_name}"
    public_key = "${tls_private_key.ssh.public_key_openssh}"
}

resource "aws_subnet" "subnet" {
  vpc_id = "${var.aws_network_vpc_id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "Main"
  }
}

resource "aws_security_group" "group_name" {
  name = "group_name"
  description = "TODO"
  vpc_id = "${var.group_name_vpc_id}"
  ingress {
    from_port = 2000
    to_port = 5010
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "group_name"
  }
}

