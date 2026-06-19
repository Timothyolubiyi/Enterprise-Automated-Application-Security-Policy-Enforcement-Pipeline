resource "aws_iam_policy" "github_policy" {

  name = "GitHubActionsPolicy"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [

          "ec2:*",

          "eks:*",

          "ecr:*",

          "elasticloadbalancing:*",

          "autoscaling:*",

          "iam:PassRole",

          "logs:*",

          "cloudwatch:*",

          "s3:*",

          "dynamodb:*"

        ]

        Resource = "*"

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "attach" {

  role = aws_iam_role.github_actions.name

  policy_arn = aws_iam_policy.github_policy.arn

}
