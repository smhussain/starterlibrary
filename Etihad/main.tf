#####################################################################
##
##      Created 11/5/18 by admin. for Etihad
##
#####################################################################

## REFERENCE {"etihad_network":{"type": "aws_reference_network"}}

terraform {
  required_version = "> 0.8.0"
}

provider "aws" {
  access_key = "${var.aws_access_id}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
  version = "~> 1.8"
}


resource "aws_instance" "etihad_instance" {
  ami = "${var.etihad_instance_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.etihad_instance_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${aws_subnet.subnet.id}"
  tags {
    Name = "${var.etihad_instance_name}"
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
  vpc_id = "${var.etihad_network_vpc_id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "Main"
  }
}