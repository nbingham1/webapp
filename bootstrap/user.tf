
# IAM User for Terraform Automation
resource "aws_iam_user" "terraform" {
  name = "terraform"
}

# IAM Policy (Modify according to your pipeline needs)
resource "aws_iam_policy" "terraform_policy" {
  name        = "TerraformPolicy"
  description = "Policy for Terraform automation"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ec2:*",
          "s3:*",
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "ssm:SendCommand",
          "ssm:GetCommandInvocation",
          "ssm:DescribeInstanceInformation",
          "ssm:ListCommands",
          "ssm:ListCommandInvocations"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "iam:PassRole",
          "iam:GetRole",
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "budgets:ViewBudget",
          "budgets:CreateBudget",
          "budgets:ModifyBudget",
          "budgets:CreateBudgetAction",
          "budgets:DeleteBudgetAction",
          "budgets:ExecuteBudgetAction",
          "budgets:DescribeBudgetAction",
          "budgets:DescribeBudgetActionsForAccount",
          "budgets:ListTagsForResource"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:CreateSecret",
          "secretsmanager:PutSecretValue"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach Policy to User
resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.terraform.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}

# Generate AWS Access Key for the User
resource "aws_iam_access_key" "terraform_key" {
  user = aws_iam_user.terraform.name
}

