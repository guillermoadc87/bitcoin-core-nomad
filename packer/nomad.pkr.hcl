packer {
  required_version = ">= 1.8.2"
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "nomad_version" {
  type    = string
  default = "1.3.1"
}

variable "consul_version" {
  type    = string
  default = "1.12.2"
}

variable "consul_template_version" {
  type    = string
  default = "0.29.1"
}

variable "ubuntu_version" {
  type    = string
  default = "16.04"
}

data "amazon-ami" "ubuntu-ami" {
  filters = {
    architecture        = "x86_64"
    name                = "*ubuntu-*-${var.ubuntu_version}-amd64-server*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
  region      = "${var.aws_region}"
}

source "amazon-ebs" "ubuntu-ami" {
  ami_description = "An Ubuntu AMI that has Nomad, Consul and Consul Template installed."
  ami_name        = "nomad-ubuntu-{{timestamp}}"
  instance_type   = "t3.micro"
  region          = "${var.aws_region}"
  source_ami      = "${data.amazon-ami.ubuntu-ami.id}"
  ssh_username    = "ubuntu"

  vpc_id = "vpc-5441b53d"

  subnet_id = "subnet-c64db1af"
}

build {
  sources = ["source.amazon-ebs.ubuntu-ami"]

  provisioner "shell" {
    inline = [
      "sudo mkdir /ops",
      "sudo chmod 777 /ops"
    ]
  }

  provisioner "file" {
    source      = "./config"
    destination = "/ops"
  }

  provisioner "file" {
    source      = "./scripts"
    destination = "/ops"
  }

  provisioner "shell" {
    environment_vars = [
      "NOMADVERSION=${var.nomad_version}",
      "CONSULVERSION=${var.consul_version}",
      "CONSULTEMPLATEVERSION=${var.consul_template_version}",
    ]
    execute_command = "sudo bash -c '{{ .Vars }} {{ .Path }}'"
    script          = "./install-nomad"
  }

}
