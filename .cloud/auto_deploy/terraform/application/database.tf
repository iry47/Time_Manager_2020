# Database instance and security group

resource "aws_instance" "database" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  count           = 1
  key_name        = var.application_key_name

  security_groups = [
    aws_security_group.database_security_group.name
  ]

  tags            = {
    Name      = "${var.stage}_time_manager_database"
    component = "database"
    stage     = var.stage
    project   = "time_manager"
  }
}

resource "aws_security_group" "database_security_group" {
  name        = "${var.stage}-tm-database-security-group"
  description = "Allow connection on port 22 and 5432"

  ingress {
    description = "SSH access port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "TCP database port"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [
      aws_security_group.server_security_group.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
