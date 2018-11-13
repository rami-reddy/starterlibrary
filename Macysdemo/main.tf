#####################################################################
##
##      Created 11/12/18 by admin. for Macysdemo
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

provider "aws" {
  access_key = "${var.aws_access_id}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
  version = "~> 1.8"
}


resource "aws_instance" "macys_aws_instance" {
  ami = "${var.macys_aws_instance_ami}"
  key_name = "${aws_key_pair.auth.id}"
  instance_type = "${var.macys_aws_instance_aws_instance_type}"
  availability_zone = "${var.availability_zone}"
  tags {
    Name = "${var.macys_aws_instance_name}"
  }
}

resource "tls_private_key" "ssh" {
    algorithm = "RSA"
}

resource "aws_key_pair" "auth" {
    key_name = "${var.aws_key_pair_name}"
    public_key = "${tls_private_key.ssh.public_key_openssh}"
}

resource "aws_ebs_volume" "macys_volume_name" {
    availability_zone = "${var.availability_zone}"
    size              = "${var.macys_volume_name_volume_size}"
}