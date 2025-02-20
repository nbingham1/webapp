# Backend Template

A basic docker-compose backend written in golang.

## Infrastructure

Set up your AWS Account
**~/.aws/credentials**
```
[default]
aws_access_key_id = ...
aws_secret_access_key = ...
```

Bootstrap the automation user for terraform
```
cd bootstrap
terraform init
terraform plan
# LOOK OVER YOUR PLAN TO MAKE SURE IT MAKES SENSE
terraform apply
# DOUBLE CHECK YOUR PLAN TO MAKE SURE IT MAKES SENSE
# type 'yes' when prompted
```

You'll see something like this on the output
```
Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

access_key_id = ...
secret_access_key = ...
```

Set up your environment
```
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
```

Manually run the terraform automation
```
cd infra
terraform init
terraform plan
# LOOK OVER YOUR PLAN TO MAKE SURE IT MAKES SENSE
terraform apply
# DOUBLE CHECK YOUR PLAN TO MAKE SURE IT MAKES SENSE
# type 'yes' when prompted
```

You'll see something like this on the output, copy the public_ip
```
Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

Outputs:

public_ip = 18.117.168.126
```

Log in to new instance using the public_ip
```
ssh -i "~/.ssh/my_ssh_key.pem" ubuntu@ec2-18-117-168-126.us-east-2.compute.amazonaws.com
```

## Container

Build the container
```
docker build -t nbingham1/backend:latest .
```

Run the container
```
docker compose up -d
```

Stop the container
```
docker compose down
```

Grab the logs
```
docker compose logs -f
```
