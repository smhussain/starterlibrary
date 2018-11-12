#####################################################################
##
##      Created 11/12/18 by DAC for dacdemo11121801
##
#####################################################################

## REFERENCE {"aws_network_dacdemo":{"type": "aws_reference_network"}}

terraform {
  required_version = "> 0.8.0"
}

provider "aws" {
  access_key = "${var.aws_access_id}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
  version = "~> 1.8"
}


resource "aws_instance" "dac_instance_11121801" {
  ami = "${var.dac_instance_11121801_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.dac_instance_11121801_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${aws_subnet.dacdemo.id}"
  tags {
    Name = "${var.dac_instance_11121801_name}"
  }
}

resource "aws_instance" "dac_instance_backup" {
  ami = "${var.dac_instance_backup_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.dac_instance_backup_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  subnet_id  = "${aws_subnet.subnet.id}"
  tags {
    Name = "${var.dac_instance_backup_name}"
  }
}

resource "tls_private_key" "ssh" {
    algorithm = "RSA"
}

resource "aws_key_pair" "auth" {
    key_name = "aws-temp-public-key"
    public_key = "${tls_private_key.ssh.public_key_openssh}"
}

resource "aws_subnet" "dacdemo" {
  vpc_id = "${var.aws_network_dacdemo_vpc_id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "Main"
  }
}

resource "aws_subnet" "dacbackup" {
  vpc_id = "${var.aws_network_dacdemo_vpc_id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "backup"
  }
}