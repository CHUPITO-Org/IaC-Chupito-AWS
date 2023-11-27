resource "aws_secretsmanager_secret" "document-credentials" {
  name        = "document-credentials"
  description = "Root user credentials for documentDB"
  # kms_key_id = "aws/secretsmanager"

  tags = {
    Project = "chupito"
  }
}

resource "aws_secretsmanager_secret_version" "document-credentials" {
  secret_id     = aws_secretsmanager_secret.document-credentials.id
  secret_string = <<EOF
  {
    "Username": "root",
    "Password": "${random_password.master_password.result}"
  }
  EOF
}
