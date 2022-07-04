//POLICY NEDEED EXAMPLE: AWSBudgetsActionsWithAWSResourceControlAccess
//
// budgets:ModifyBudget action required
//


resource "aws_budgets_budget" "project_billing" {
  name         = "budget-monthly"
  budget_type  = "COST"
  limit_amount = "5"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"


  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.email_notif_list
  }
}