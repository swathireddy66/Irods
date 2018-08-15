provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.small"
  user= EOF <<
   "apt-get update -y";
   "apt-get install software-properties-common";
   "apt-add-repository ppa:ansible/ansible";
   "apt-get update && sudo apt-get install ansible
   >>
   EOF
  

  tags {
    Name = "Irods"
  }
}
