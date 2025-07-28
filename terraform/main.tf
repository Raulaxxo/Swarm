provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "mis_maquinas" {
  count                  = 3
  ami                    = "ami-020cba7c55df1f615"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-00ffe6a72054ab086"
  availability_zone      = "us-east-1b"
  key_name               = "MiClaveSSH"

  vpc_security_group_ids = [
    "sg-0af2298f8e3ae9edb",  # entremaquinas
    "sg-08c41a3de52d67366"   # launch-wizard-1
  ]

  user_data = file("${path.module}/init.sh")

  tags = {
    Name = "mi-maquina-${count.index + 1}"
  }
}

output "public_ips" {
  value = [for instance in aws_instance.mis_maquinas : instance.public_ip]
}
