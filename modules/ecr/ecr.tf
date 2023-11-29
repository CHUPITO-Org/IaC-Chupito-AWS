#Create AWS ECR Repository
resource "aws_ecr_repository" "ecr_backend" {
  name                 = "backend-image"
  image_tag_mutability = var.image_mutability
  force_delete         = true

  encryption_configuration {
    encryption_type = var.encrypt_type
  }

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Project = "chupito"
  }
}


#Create AWS ECR Repository
resource "aws_ecr_repository" "ecr" {
  name                 = var.ecr_name
  image_tag_mutability = var.image_mutability
  force_delete         = true

  encryption_configuration {
    encryption_type = var.encrypt_type
  }

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Project = "chupito"
  }
}

