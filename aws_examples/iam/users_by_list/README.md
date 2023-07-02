# Get password by email

terraform state show 'aws_iam_user_login_profile.login_user_mail["email_in_list@hello.poc"]' | grep "password"
