# Server instance, security group and elb

resource "aws_instance" "server" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  count           = var.server_instance_count
  key_name        = var.application_key_name

  security_groups = [
    aws_security_group.server_security_group.name
  ]

  tags            = {
    Name      = "${var.stage}_time_manager_server"
    component = "server"
    stage     = var.stage
    project   = "time_manager"
  }
}

resource "aws_security_group" "server_security_group" {
  name        = "${var.stage}-tm-server-security-group"
  description = "Allow connection on port 22 and 3000 for server"

  ingress {
    description = "SSH access port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP server port"
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "server_elb" {
  name               = "${var.stage}-tm-server-elb"
  availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]

  listener {
    instance_port     = 4000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    interval            = 30
    target              = "HTTP:4000/blank"
    timeout             = 3
    unhealthy_threshold = 2
  }

  instances                   = aws_instance.server.*.id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.stage}_time_manager_server_elb"
  }
}
