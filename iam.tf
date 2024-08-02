# Define IAM Role
resource "aws_iam_role" "ec2_role" {
  name = "ec2_s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach policy to the role
resource "aws_iam_role_policy_attachment" "s3_read_only" {
  role       = aws_iam_role.ec2_role.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

