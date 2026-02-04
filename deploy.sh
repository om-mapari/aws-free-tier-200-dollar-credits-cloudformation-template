#!/bin/bash

# AWS Credits Activities - Deployment Script
# This script deploys the CloudFormation template to earn AWS credits

set -e

echo "=========================================="
echo "AWS Credits Activities Deployment"
echo "=========================================="
echo ""

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "❌ AWS CLI is not installed. Please install it first:"
    echo "   https://aws.amazon.com/cli/"
    exit 1
fi

# Check AWS credentials
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS credentials not configured. Run: aws configure"
    exit 1
fi

echo "✅ AWS CLI configured"
echo ""

# Get user input
read -p "Enter your email address for billing alerts: " EMAIL
read -p "Enter monthly budget amount in USD (default: 1): " BUDGET
BUDGET=${BUDGET:-1}
read -p "Enter billing alarm threshold in USD (default: 0.1): " ALARM_THRESHOLD
ALARM_THRESHOLD=${ALARM_THRESHOLD:-0.1}
read -p "Enter AWS region (default: ap-south-1): " REGION
REGION=${REGION:-ap-south-1}

TEMPLATE_FILE="aws-credits-activities.yaml"
STACK_NAME="aws-credits-stack"

echo ""
echo "Deploying stack: $STACK_NAME"
echo "Template: $TEMPLATE_FILE"
echo "Email: $EMAIL"
echo "Budget: \$$BUDGET USD"
echo "Billing Alarm: \$$ALARM_THRESHOLD USD"
echo "Region: $REGION"
echo ""

read -p "Continue? (y/n): " CONFIRM
if [ "$CONFIRM" != "y" ]; then
    echo "Deployment cancelled"
    exit 0
fi

echo ""
echo "🚀 Creating CloudFormation stack..."

aws cloudformation create-stack \
  --stack-name "$STACK_NAME" \
  --template-body "file://$TEMPLATE_FILE" \
  --parameters \
    ParameterKey=EmailAddress,ParameterValue="$EMAIL" \
    ParameterKey=BudgetAmount,ParameterValue="$BUDGET" \
    ParameterKey=BillingAlarmThreshold,ParameterValue="$ALARM_THRESHOLD" \
  --capabilities CAPABILITY_NAMED_IAM \
  --region "$REGION"

echo ""
echo "⏳ Waiting for stack creation (this may take 10-15 minutes)..."
echo ""

aws cloudformation wait stack-create-complete \
  --stack-name "$STACK_NAME" \
  --region "$REGION"

echo ""
echo "✅ Stack created successfully!"
echo ""
echo "=========================================="
echo "Next Steps:"
echo "=========================================="
echo ""
echo "1. ✉️  Check your email and CONFIRM the SNS subscription"
echo ""
echo "2. 🔗 Test your Lambda function:"
LAMBDA_URL=$(aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --query 'Stacks[0].Outputs[?OutputKey==`LambdaFunctionURL`].OutputValue' \
  --output text \
  --region "$REGION")
echo "   $LAMBDA_URL"
echo ""
echo "3. 📊 View your resources:"
echo "   - EC2: https://console.aws.amazon.com/ec2"
echo "   - RDS: https://console.aws.amazon.com/rds"
echo "   - Lambda: https://console.aws.amazon.com/lambda"
echo "   - Budgets: https://console.aws.amazon.com/billing/home#/budgets"
echo ""
echo "4. 🤖 Complete Bedrock activity manually:"
echo "   - Go to: https://console.aws.amazon.com/bedrock"
echo "   - Click 'Playgrounds' > 'Chat'"
echo "   - Select a model and test it"
echo ""
echo "5. ✅ Verify activities completed:"
echo "   - Go to AWS Console Home"
echo "   - Check 'Explore AWS' widget"
echo "   - Should show: 5 of 5 activities completed"
echo ""
echo "6. 💰 Check your credits (after 24-48 hours):"
echo "   - Go to: https://console.aws.amazon.com/billing/home#/credits"
echo ""
echo "=========================================="
echo "⚠️  IMPORTANT: Cleanup to avoid charges"
echo "=========================================="
echo ""
echo "After credits appear, DELETE the stack:"
echo "  aws cloudformation delete-stack --stack-name $STACK_NAME --region $REGION"
echo ""
echo "Then deploy billing protection (optional but recommended):"
echo "  aws cloudformation create-stack \\"
echo "    --stack-name billing-protection \\"
echo "    --template-body file://billing-alarm.yaml \\"
echo "    --parameters \\"
echo "      ParameterKey=EmailAddress,ParameterValue=$EMAIL \\"
echo "      ParameterKey=BudgetAmount,ParameterValue=10 \\"
echo "      ParameterKey=BillingAlarmThreshold,ParameterValue=5 \\"
echo "    --region $REGION"
echo ""
