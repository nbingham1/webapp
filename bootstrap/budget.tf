resource "aws_budgets_budget" "zero_budget" {
  name              = "ZeroDollarBudget"
  budget_type       = "COST"
  limit_amount      = "1.00"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator = "GREATER_THAN"
    threshold           = 0.01
    threshold_type      = "ABSOLUTE_VALUE"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = ["edward.bingham@broccolimicro.io"]
  }
}

