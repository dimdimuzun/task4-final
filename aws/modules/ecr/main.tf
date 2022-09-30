# ECR 
resource "aws_ecr_repository" "this" {
  name                 = "${var.environment}-${var.app_name}"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = false
  }
}
# Leave old images not more then "build_count"
resource "aws_ecr_lifecycle_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last ${var.build_count} images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.build_count}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
