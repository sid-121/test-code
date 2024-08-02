# Define a security group to allow traffic on port 5000
resource "aws_security_group" "allow_sg" {
  name_prefix = "flask_sg_"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define an EC2 instance with IAM role
resource "aws_instance" "flask_instance" {
  ami           = "ami-0814efd714b06daf3"  # Replace with an appropriate AMI ID for your region
  instance_type = "t2.micro"
  key_name      = "tenant-eks-bastion"  # Ensure you have created this key pair in AWS

  security_groups = [aws_security_group.allow_sg.name]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt-get install -y python3-pip git
              pip3 install flask boto3
              git clone https://github.com/sid-121/exam-code.git /home/ec2-user/app
              cd /home/ec2-user/app
              nohup python3 code.py &
              EOF

  tags = {
    Name = "FlaskAppInstance"
  }
}

# Define IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

# Output the public IP of the instance
output "instance_ip" {
  value = aws_instance.flask_instance.public_ip
}

