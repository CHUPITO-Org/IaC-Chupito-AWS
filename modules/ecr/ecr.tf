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
  tags = var.tags

  provisioner "local-exec" {
    command = <<-EOT
        docker image tag hello-world-react:latest '${aws_ecr_repository.ecr.repository_url}':latest
        aws ecr get-login-password --region '${var.aws_region}' | docker login --username AWS --password-stdin '${aws_ecr_repository.ecr.repository_url}'
        docker image push '${aws_ecr_repository.ecr.repository_url}':latest
      EOT
  }
  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
          docker image rm 041581428422.dkr.ecr.us-east-1.amazonaws.com/hello-world-react:latest
      EOT
  }
}

