output "ec2_instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.credit_activity.id
}

output "ec2_public_ip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.credit_activity.public_ip
}

output "lambda_function_name" {
  description = "Lambda Function Name"
  value       = aws_lambda_function.web_app.function_name
}

output "lambda_function_url" {
  description = "Lambda Function URL (test this to complete the activity)"
  value       = aws_lambda_function_url.web_app_url.function_url
}

output "rds_endpoint" {
  description = "RDS Database Endpoint"
  value       = aws_db_instance.credit_activity.endpoint
}

output "rds_port" {
  description = "RDS Database Port"
  value       = aws_db_instance.credit_activity.port
}

output "db_secret_arn" {
  description = "ARN of the Secrets Manager secret containing DB password"
  value       = aws_secretsmanager_secret.db_password.arn
}

output "budget_name" {
  description = "AWS Budget Name"
  value       = aws_budgets_budget.monthly_budget.name
}

output "sns_topic_arn" {
  description = "SNS Topic for Budget Alerts"
  value       = aws_sns_topic.budget_alerts.arn
}

output "bedrock_note" {
  description = "Bedrock Activity Instructions"
  value       = "For Bedrock activity, manually visit AWS Console > Bedrock > Playgrounds and test a foundation model"
}
