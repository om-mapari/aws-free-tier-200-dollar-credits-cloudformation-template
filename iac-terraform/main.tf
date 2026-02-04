terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ============================================
# ACTIVITY 1: Set up a cost budget using AWS Budgets ($20 credit)
# ============================================

resource "aws_sns_topic" "budget_alerts" {
  name         = "BudgetAlertTopic"
  display_name = "AWS Budget Alerts"
}

resource "aws_sns_topic_subscription" "budget_email" {
  topic_arn = aws_sns_topic.budget_alerts.arn
  protocol  = "email"
  endpoint  = var.email_address
}

resource "aws_budgets_budget" "monthly_budget" {
  name         = "MonthlySpendingBudget"
  budget_type  = "COST"
  limit_amount = var.budget_amount
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 80
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_sns_topic_arns = [aws_sns_topic.budget_alerts.arn]
  }

  notification {
    comparison_operator       = "GREATER_THAN"
    threshold                 = 100
    threshold_type            = "PERCENTAGE"
    notification_type         = "FORECASTED"
    subscriber_sns_topic_arns = [aws_sns_topic.budget_alerts.arn]
  }
}

resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "BillingAlert-${var.billing_alarm_threshold}USD"
  alarm_description   = "Alert when estimated charges exceed $${var.billing_alarm_threshold}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 21600
  statistic           = "Maximum"
  threshold           = var.billing_alarm_threshold
  treat_missing_data  = "notBreaching"

  dimensions = {
    Currency = "USD"
  }

  alarm_actions = [aws_sns_topic.budget_alerts.arn]
}

# ============================================
# ACTIVITY 2: Launch an instance using EC2 ($20 credit)
# ============================================

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "CreditActivitySG"
  description = "Security group for credit activity EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access (restrict this in production!)"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "CreditActivity-SG"
    Purpose = "AWSCreditsActivity"
  }
}

resource "aws_instance" "credit_activity" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              echo "EC2 instance launched for AWS credits activity" > /tmp/activity.log
              EOF

  tags = {
    Name    = "CreditActivity-EC2"
    Purpose = "AWSCreditsActivity"
  }

  depends_on = [
    aws_lambda_function.web_app,
    aws_db_instance.credit_activity,
    aws_budgets_budget.monthly_budget
  ]
}

# ============================================
# ACTIVITY 3: Create a web app using AWS Lambda ($20 credit)
# ============================================

resource "aws_iam_role" "lambda_role" {
  name = "CreditActivityLambdaRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Purpose = "AWSCreditsActivity"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "web_app" {
  function_name = "CreditActivityWebApp"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.12"

  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  description = "Simple web app for AWS credits activity"

  tags = {
    Purpose = "AWSCreditsActivity"
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda_function.zip"

  source {
    content  = <<-EOF
      import json
      
      def lambda_handler(event, context):
          return {
              'statusCode': 200,
              'headers': {
                  'Content-Type': 'application/json',
                  'Access-Control-Allow-Origin': '*'
              },
              'body': json.dumps({
                  'message': 'Hello from AWS Lambda!',
                  'purpose': 'AWS Credits Activity',
                  'activity': 'Create a web app using AWS Lambda'
              })
          }
    EOF
    filename = "index.py"
  }
}

resource "aws_lambda_function_url" "web_app_url" {
  function_name      = aws_lambda_function.web_app.function_name
  authorization_type = "NONE"

  cors {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST"]
    max_age       = 300
  }
}

# ============================================
# ACTIVITY 4: Create an Aurora or RDS database ($20 credit)
# ============================================

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "db_password" {
  name        = "CreditActivityDBPassword"
  description = "RDS database password for credit activity"

  tags = {
    Purpose = "AWSCreditsActivity"
  }
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = "admin"
    password = random_password.db_password.result
  })
}

resource "aws_db_instance" "credit_activity" {
  identifier              = "credit-activity-db"
  engine                  = "mysql"
  engine_version          = "8.0.40"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp3"
  username                = "admin"
  password                = random_password.db_password.result
  publicly_accessible     = true
  skip_final_snapshot     = true
  backup_retention_period = 1

  tags = {
    Purpose = "AWSCreditsActivity"
  }
}
