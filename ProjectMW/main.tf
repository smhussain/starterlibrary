#####################################################################
##
##      Created 3/15/19 by admin. for ProjectMW
##
#####################################################################

## REFERENCE {"aws_network_MW":{"type": "aws_reference_network"}}

terraform {
  required_version = "> 0.8.0"
}

provider "aws" {
  access_key = "${var.aws_access_id}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
  version = "~> 1.8"
}


resource "aws_instance" "Project_MW" {
  ami = "${var.Project_MW_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.Project_MW_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${aws_subnet.subnet_MW.id}"
  tags {
    Name = "${var.Project_MW_name}"
  }
}

resource "tls_private_key" "ssh" {
    algorithm = "RSA"
}

resource "aws_key_pair" "auth" {
    key_name = "${var.aws_key_pair_name}"
    public_key = "${tls_private_key.ssh.public_key_openssh}"
}

resource "aws_subnet" "subnet_MW" {
  vpc_id = "${var.aws_network_MW_vpc_id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "Main"
  }
}