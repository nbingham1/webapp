# This costs money!!!

# Store Credentials in AWS Secrets Manager (Optional)
# resource "aws_secretsmanager_secret" "terraform_secret" {
#   name = "terraform-pipeline-credentials"
# }

# resource "aws_secretsmanager_secret_version" "terraform_secret_value" {
#   secret_id     = aws_secretsmanager_secret.terraform_secret.id
#   secret_string = jsonencode({
#     AWS_ACCESS_KEY_ID     = aws_iam_access_key.terraform_key.id
#     AWS_SECRET_ACCESS_KEY = aws_iam_access_key.terraform_key.secret
#   })
# }

# output "secret_manager_arn" {
#   value = aws_secretsmanager_secret.terraform_secret.arn
# }
