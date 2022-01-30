resource "aws_iam_user" "user" {
  for_each = local.users
  name     = each.value.name
  tags     = each.value.tags
}

resource "aws_iam_access_key" "access_key" {
  for_each   = local.users
  user       = aws_iam_user.user[each.key].name
}

resource "aws_iam_user_policy" "policy" {
  for_each = local.users
  name     = "${each.value.name}-policy"
  user     = aws_iam_user.user[each.key].name
  policy   = each.value.policy
}

resource "aws_kms_key" "sops_key" {
  for_each                = local.keys
  description             = each.value.description
  deletion_window_in_days = each.value.deletion_window_in_days
  policy                  = each.value.policy
  enable_key_rotation     = each.value.enable_key_rotation
  tags                    = each.value.tags
}
