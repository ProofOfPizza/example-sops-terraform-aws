output "keys" {
  value = aws_kms_key.sops_key.*
}

output "users" {
  value = aws_iam_user.user.*
}

output "access_keys" {
  value     = aws_iam_access_key.access_key.*
  sensitive = true
}
