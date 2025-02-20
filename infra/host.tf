resource "aws_security_group" "my_security_group" {
	name        = "my_security_group"
	description = "Allow HTTP and SSH"

	# HTTP
	ingress {
		from_port   = 80
		to_port     = 3000
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# HTTPS
	ingress {
		from_port   = 443
		to_port     = 3000
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# API
	ingress {
		from_port   = 5000
		to_port     = 5000
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# SSH
	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# All egress allowed
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "tls_private_key" "my_ssh_private_key" {
	algorithm = "RSA"
	rsa_bits  = 4096
}

resource "aws_key_pair" "my_ssh_key" {
	key_name   = "my_ssh_key"
	public_key = tls_private_key.my_ssh_private_key.public_key_openssh
}

resource "aws_instance" "my_host" {
	ami           = "ami-0cb91c7de36eed2cb"
	instance_type = "t2.micro"
	key_name      = aws_key_pair.my_ssh_key.key_name
	security_groups = [aws_security_group.my_security_group.name]
	associate_public_ip_address = true

	user_data = file("setup.sh")

	tags = {
		Name = "MyHost"
	}
}

resource "aws_budgets_budget_action" "my_shutdown" {
	budget_name        = data.aws_budgets_budget.zero_budget.name
	action_type        = "RUN_SSM_DOCUMENTS"
	approval_model     = "AUTOMATIC"
	notification_type  = "ACTUAL"
	execution_role_arn = data.aws_iam_role.budget_ec2.arn

	action_threshold {
		action_threshold_type  = "ABSOLUTE_VALUE"
		action_threshold_value = 0.01
	}

	definition {
		ssm_action_definition {
			action_sub_type = "STOP_EC2_INSTANCES"
			instance_ids = [aws_instance.my_host.id]
			region = local.region
		}
	}

	subscriber {
		address           = "edward.bingham@broccolimicro.io"
		subscription_type = "EMAIL"
	}
}
