locals {
  my_aws_user = "arn:aws:iam::640753244498:user/iam_user_name"
}

locals {
  users = {
    prod = {
      name = "prod_user"
      tags = {
        environment = "prod"
      }
      policy = file("./policies/user-policy.json")
    }
    test = {
      name = "test_user"
      tags = {
        environment = "test"
      }
      policy = file("./policies/user-policy.json")
    }
    key_admin = {
      name = "key_admin_user"
      tags = {
        environment = "all"
      }
      policy = file("./policies/key-admin-policy.json")
    }
  }
}

locals {
  keys = {
    prod = {
      description             = "Key for prod env using SOPS"
      deletion_window_in_days = 10
      policy                  = templatefile("./policies/key-policy.tpl", {key_users = [aws_iam_user.user["prod"].arn], key_admins = [aws_iam_user.user["key_admin"].arn, local.my_aws_user]})
      enable_key_rotation     = true
      tags = {
        use         = "example"
        environment = "prod"
      }
    }
    test = {
      description             = "Key for test env using SOPS"
      deletion_window_in_days = 7
      policy                  = templatefile("./policies/key-policy.tpl", {key_users = [aws_iam_user.user["test"].arn, aws_iam_user.user["prod"].arn], key_admins = [aws_iam_user.user["key_admin"].arn, local.my_aws_user]})
      enable_key_rotation     = true
      tags = {
        use         = "example"
        environment = "test"
      }
    }
  }
}


