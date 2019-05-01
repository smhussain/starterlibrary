provider "aws" {
  version = "1.56.0"
}

provider "tls" {
  version = "1.2.0"
}

variable "aws_region" {
  description = "Enter the AWS region"
}

variable "aws_vpc_name" {
  description = "Enter the Name of VPC"
}

variable "aws_Security_Group_name" {
  description = "Enter the Security group Name"
}

variable "aws_S3_bukcet_name" {
  description = "Enter the S3 bucket Name"
}

variable "aws_key_pair_name" {
  description = "Enter the key pair Name"
}

variable "mysql_user" {
  description = "Enter the mysql user name"
}

variable "mysql_password" {
  description = "Enter the mysql password"
}

variable "mysql_database" {
  description = "Enter the mysql database name"
}

variable "emr_subnet" {
  default = "EMR & MySQL subnet"
}

variable "emr_subnet1" {
  default = "MySQL subnet 1"
}

resource "aws_db_subnet_group" "mysql" {
  subnet_ids = ["${var.emr_subnet}", "${var.emr_subnet1}"]
}

data "aws_iam_role" "EMR_DefaultRole" {
  name = "EMR_DefaultRole"
}

resource "aws_iam_role_policy_attachment" "emr-service-policy-attach" {
  role       = "${data.aws_iam_role.EMR_DefaultRole.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

data "aws_iam_role" "EMR_EC2_DefaultRole" {
  name = "EMR_Tag"
}

resource "aws_iam_role_policy_attachment" "profile-policy-attach" {
  role       = "${data.aws_iam_role.EMR_EC2_DefaultRole.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}

resource "aws_iam_instance_profile" "emr_profile" {
  name = "vinod_spark_cluster_emr_profile"
  role = "${data.aws_iam_role.EMR_EC2_DefaultRole.name}"
}

data "aws_security_group" "security_group" {
  id = "${var.aws_Security_Group_name}"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_db_instance" "MySQL" {
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "${var.mysql_database}"
  username               = "${var.mysql_user}"
  password               = "${var.mysql_password}"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = "${aws_db_subnet_group.mysql.id}"
  vpc_security_group_ids = ["${var.aws_Security_Group_name}"]
  publicly_accessible    = false
}

resource "aws_key_pair" "emr_key_pair" {
  key_name   = "${var.aws_key_pair_name}"
  public_key = "${tls_private_key.example.public_key_openssh}"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.aws_S3_bukcet_name}"
  region = "${var.aws_region}"
}

resource "aws_emr_cluster" "emr-spark-cluster" {
  name          = "Vinod-EMR-cluster-example"
  release_label = "emr-5.9.0"
  applications  = ["Hadoop", "Hive", "Mahout", "Pig", "Hue", "Tez", "Ganglia"]

  ec2_attributes {
    instance_profile                  = "${aws_iam_instance_profile.emr_profile.arn}"
    key_name                          = "${aws_key_pair.emr_key_pair.key_name}"
    subnet_id                         = "${var.emr_subnet}"
    emr_managed_master_security_group = "${var.aws_Security_Group_name}"
    emr_managed_slave_security_group  = "${var.aws_Security_Group_name}"
  }

  instance_group {
    instance_role  = "MASTER"
    instance_type  = "m4.large"
    instance_count = "1"
  }

  instance_group {
    instance_role  = "CORE"
    instance_type  = "m4.large"
    instance_count = "2"
  }

  log_uri = "s3://${aws_s3_bucket.s3_bucket.bucket}"

  tags {
    name = "EMR-cluster"
    role = "EMR_DefaultRole"
  }

  configurations_json = <<EOF
  [
    {
      "Classification": "hive-site",
      "Properties": {
        "javax.jdo.option.ConnectionURL": "jdbc:mysql:\/\/${aws_db_instance.MySQL.endpoint}\/hive?createDatabaseIfNotExist=true",
        "javax.jdo.option.ConnectionDriverName": "org.mariadb.jdbc.Driver",
        "javax.jdo.option.ConnectionUserName": "${aws_db_instance.MySQL.username}",
        "javax.jdo.option.ConnectionPassword": "${aws_db_instance.MySQL.password}"
      }
    }
  ]
EOF

  service_role = "${data.aws_iam_role.EMR_DefaultRole.arn}"
}

output "private_key" {
  value = "${tls_private_key.example.private_key_pem}"
}

output "mySQLendpoint" {
  value = "${aws_db_instance.MySQL.endpoint}"
}
