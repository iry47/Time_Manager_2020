resource "aws_instance" "monitoring" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  count           = 1
  key_name        = var.application_key_name

  security_groups = [
    aws_security_group.monitoring_security_group.name
  ]

  tags            = {
    Name      = "${var.stage}_time_manager_monitoring"
    component = "monitoring"
    stage     = var.stage
    project   = "time_manager"
  }
}

resource "aws_security_group" "monitoring_security_group" {
  name        = "${var.stage}-tm-monitoring-security-group"
  description = "Allow connection on port 22, 80 and 8086 for monitoring"

  ingress {
    description = "SSH access port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP monitoring client port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP monitoring database port"
    from_port   = 8086
    to_port     = 8086
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