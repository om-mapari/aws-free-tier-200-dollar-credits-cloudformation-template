# Terraform - AWS Credits Automation

This directory contains Terraform configuration to automate earning $100 AWS credits.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS CLI configured with credentials
- New AWS account (Free Plan or Paid Plan)

## Quick Start

### 1. Install Terraform

**macOS:**
```bash
brew install terraform
```

**Linux:**
```bash
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

**Windows:**
Download from [terraform.io](https://www.terraform.io/downloads.html)

### 2. Configure AWS Credentials

```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Default region: ap-south-1
# Default output format: json
```

### 3. Initialize Terraform

```bash
cd iac-terraform
terraform init
```

### 4. Configure Variables

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your email and preferences
```

### 5. Plan Deployment

```bash
terraform plan
```

### 6. Deploy Resources

```bash
terraform apply
```

Type `yes` when prompted.

### 7. Get Outputs

```bash
terraform output
```

Copy the Lambda Function URL and test it in your browser.

### 8. Complete Bedrock Activity

1. Go to [Amazon Bedrock Console](https://console.aws.amazon.com/bedrock)
2. Click "Playgrounds" → "Chat"
3. Select any model and test it

### 9. Verify Credits

1. Go to AWS Console Home
2. Check "Explore AWS" widget
3. Should show: 5 of 5 activities completed
4. Credits appear within 10 minutes

### 10. Destroy Resources

**Important:** Delete resources after earning credits to avoid charges!

```bash
terraform destroy
```

Type `yes` when prompted.

## What Gets Created

- ✅ AWS Budget with email alerts
- ✅ CloudWatch Billing Alarm
- ✅ EC2 t3.micro instance
- ✅ Lambda function with public URL
- ✅ RDS MySQL db.t3.micro database
- ✅ Security groups
- ✅ IAM roles
- ✅ Secrets Manager secret

## Cost Estimates

| Resource | Monthly Cost | Free Tier |
|----------|--------------|-----------|
| EC2 t3.micro | ~$7.50 | 750 hrs/month |
| RDS db.t3.micro | ~$12.24 | 750 hrs/month |
| Lambda | ~$0.00 | 1M requests |
| Others | $0.00 | Free |

**Total if within Free Tier:** $0.00

## Troubleshooting

### Terraform init fails
```bash
rm -rf .terraform .terraform.lock.hcl
terraform init
```

### Apply fails with "already exists"
```bash
terraform import aws_sns_topic.budget_alerts <topic-arn>
```

### RDS creation timeout
RDS takes 10-15 minutes. Be patient or increase timeout:
```hcl
resource "aws_db_instance" "credit_activity" {
  # ... other config
  timeouts {
    create = "30m"
  }
}
```

## Files

- `main.tf` - Main Terraform configuration
- `variables.tf` - Input variables
- `outputs.tf` - Output values
- `terraform.tfvars.example` - Example variables file
- `README.md` - This file

## Notes

- Confirm SNS email subscription after deployment
- Lambda function URL is publicly accessible
- RDS is publicly accessible (for demo only)
- Delete resources after earning credits
- Budget and billing alarm remain for protection
