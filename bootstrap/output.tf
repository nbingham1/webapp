
# Set `sensitive = true` if this will be used in automation!
output "access_key_id" {
  value     = aws_iam_access_key.terraform_key.id
  # sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.terraform_key.secret
  # sensitive = true
}
