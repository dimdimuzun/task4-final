
resource "aws_security_group" "codebuild_sg" {
  vpc_id = var.vpc_id
  name   = "codebuild security group"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "codebuild-sg-${var.environment}-${var.app_name}"
  }
}
