output "access_key_id" {
  value     = aws_iam_access_key.terraform_key.id
  sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.terraform_key.secret
  sensitive = true
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}
