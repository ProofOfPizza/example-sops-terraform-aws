resource "aws_kms_key" "sops_key" {
  description             = "Key for sops"
  deletion_window_in_days = 10
  policy                  = file("./key-policy.json")
  enable_key_rotation     = true
  tags                    = {
    use = "personal"
  }
}
