provider "aws" {
 region = var.region  
}

resource "aws_instance" "ec2_example" {

    ami = var.ami
    instance_type = var.type
    vpc_security_group_ids = [aws_security_group.Deepanshu.id]
    associate_public_ip_address = true

  user_data = <<-EOF
      #!/bin/sh
      sudo apt-get update -u
      sudo apt install -y nginx
      sudo systemctl start nginx
      sudo echo "<html><body><h1>Hello this is test module1 at instance id `curl http://169.254.169.254/latest/meta-data/instance-id` </h1></body></html>" > /var/www/html/index.html
      EOF
}

resource "aws_security_group" "Deepanshu" {
    name        = "EC2-webserver-SG12345Deepanshu"
  description = "Webserver for EC2 Instances"

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
