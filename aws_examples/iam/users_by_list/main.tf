provider "aws" {
  region = var.region
}

resource "aws_iam_user" "user_mail" {
  for_each      = toset(var.email_list)
  name          = each.key
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "login_user_mail" {
    for_each = aws_iam_user.user_mail
    user    = each.key
    depends_on = [aws_iam_user.user_mail]
    password_reset_required = true
}

//output "password" { # TODO : print passwords?
//  value = aws_iam_user_login_profile.login_user_mail
//  depends_on = [aws_iam_user_login_profile.login_user_mail]
//}