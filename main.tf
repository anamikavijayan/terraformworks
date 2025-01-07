# 1. Define the AWS provider
provider "aws" {
  region = "ap-south-1"  # Set the AWS region
}

# 3. Create an EC2 instance
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0fd05997b4dff7aac"  # Replace with your AMI ID
  instance_type = "t2.micro"               # Choose instance type

  # Specify the key pair for SSH access
  key_name = "anamika-aws-key"  # Replace with your key pair name

  # Attach the existing security group by ID
  vpc_security_group_ids = ["sg-08fa7a702d5ae190c"]  # Corrected to security_group_ids

  # Optional: Tag your instance
  tags = {
    Name = "NginxInstance"
  }

  # Optional: Additional settings (e.g., block_device, subnet_id, etc.)
}

# (Optional) Output the instance public IP address
output "instance_public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}

