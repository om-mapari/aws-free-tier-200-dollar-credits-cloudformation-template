# 🎁 AWS Free Credits Automation - Earn $100 in 15 Minutes

**Automated CloudFormation template to earn $100 AWS credits for new Free Tier accounts.**

Automates 4 out of 5 credit activities ($80). Complete the 5th (Bedrock) manually in 2 minutes for the final $20.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 📑 Table of Contents

- [What You'll Get](#-what-youll-get)
- [Prerequisites](#-prerequisites)
- [Quick Start Guide](#-quick-start-guide)
  - [Step 1: Create AWS Account](#step-1-create-aws-account-if-needed)
  - [Step 2: Deploy CloudFormation Template](#step-2-deploy-cloudformation-template)
  - [Step 3: Confirm Email Subscription](#step-3-confirm-email-subscription)
  - [Step 4: Verify Activities Completed](#step-4-verify-activities-completed)
  - [Step 5: Complete Bedrock Activity](#step-5-complete-bedrock-activity-2-minutes)
  - [Step 6: Verify Credits Earned](#step-6-verify-credits-earned)
  - [Step 7: Delete Resources](#step-7-delete-resources-important)
  - [Step 8: Keep Billing Protection](#step-8-keep-billing-protection-recommended)
- [Cost Breakdown](#-cost-breakdown)
- [Billing Protection](#-billing-protection)
- [Repository Files](#-repository-files)
- [Troubleshooting](#-troubleshooting)
- [What You'll Learn](#-what-youll-learn)
- [Important Notes](#-important-notes)
- [Contributing](#-contributing)
- [License](#-license)
- [Pro Tips](#-pro-tips)
- [Support](#-support)

---

## 🎯 What You'll Get

| Activity | Credit | Automated? |
|----------|--------|------------|
| Set up AWS Budgets | $20 | ✅ Yes |
| Launch EC2 Instance | $20 | ✅ Yes |
| Create Lambda Web App | $20 | ✅ Yes |
| Create RDS Database | $20 | ✅ Yes |
| Use Bedrock AI Model | $20 | ⚠️ Manual (2 min) |

**Total: $100 in AWS credits**
- **Free Plan**: Valid for 6 months or until exhausted
- **Paid Plan**: Valid for 12 months from sign-up

---

## 📋 Prerequisites

✅ **New AWS account** (created after July 15, 2025)  
✅ **Free Plan or Paid Plan** account type  
✅ **Email address** for billing alerts  
✅ **10-15 minutes** of your time

**That's it!** No AWS CLI needed for console deployment.

---

## 🚀 Quick Start Guide

### Step 1: Create AWS Account (if needed)

1. Go to [aws.amazon.com](https://aws.amazon.com)
2. Click "Create an AWS Account"
3. Choose **Free Plan** (6 months, no charges) or **Paid Plan** (full access)
4. Complete signup

### Step 2: Deploy CloudFormation Template

**Option A: AWS Console (Recommended)**

1. Download [`aws-credits-activities.yaml`](aws-credits-activities.yaml)
2. Go to [CloudFormation Console](https://console.aws.amazon.com/cloudformation)
3. Click **"Create stack"** → **"With new resources"**
4. Choose **"Upload a template file"**
5. Upload `aws-credits-activities.yaml`
6. Click **"Next"**

**Configure Stack:**
- Stack name: `aws-credits-stack`
- Email: `your-email@example.com`
- Budget: `1` (USD)
- Billing Alarm: `0.1` (USD)
- Click **"Next"** → **"Next"**

**Deploy:**
- Check ✅ **"I acknowledge that AWS CloudFormation might create IAM resources"**
- Click **"Submit"**
- Wait 10-15 minutes ☕

**Option B: AWS CLI**

**Prerequisites:**
1. Install AWS CLI: [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
2. Configure AWS CLI with your credentials:

```bash
# Configure AWS CLI
aws configure

# You'll be prompted for:
# AWS Access Key ID: [Your access key]
# AWS Secret Access Key: [Your secret key]
# Default region name: ap-south-1
# Default output format: json
```

**Get AWS Credentials:**
1. Go to [IAM Console](https://console.aws.amazon.com/iam)
2. Click **"Users"** → **"Create user"** (or use existing)
3. Attach **"AdministratorAccess"** policy
4. Go to **"Security credentials"** tab
5. Click **"Create access key"**
6. Choose **"Command Line Interface (CLI)"**
7. Copy **Access Key ID** and **Secret Access Key**

**Deploy:**

```bash
# Clone the repository
git clone https://github.com/om-mapari/aws-free-tier-100-dollar-credits-cloudformation-template.git
cd aws-free-tier-100-dollar-credits-cloudformation-template

# Deploy the stack
aws cloudformation create-stack \
  --stack-name aws-credits-stack \
  --template-body file://aws-credits-activities.yaml \
  --parameters \
    ParameterKey=EmailAddress,ParameterValue=your-email@example.com \
    ParameterKey=BudgetAmount,ParameterValue=1 \
    ParameterKey=BillingAlarmThreshold,ParameterValue=0.1 \
  --capabilities CAPABILITY_NAMED_IAM \
  --region ap-south-1

# Monitor progress
aws cloudformation describe-stacks \
  --stack-name aws-credits-stack \
  --query 'Stacks[0].StackStatus'
```

**Option C: Terraform**

See the [Terraform README](iac-terraform/README.md) for detailed instructions.

```bash
cd iac-terraform
terraform init
terraform apply
```

### Step 3: Confirm Email Subscription

1. Check your email inbox
2. Look for "AWS Notification - Subscription Confirmation"
3. Click **"Confirm subscription"**

### Step 4: Verify Activities Completed

1. Go to [AWS Console Home](https://console.aws.amazon.com)
2. Find **"Explore AWS"** widget
3. Check activities marked as **"Completed"**

You should see:
- ✅ Set up a cost budget using AWS Budgets
- ✅ Launch an instance using EC2
- ✅ Create a web app using AWS Lambda
- ✅ Create an Aurora or RDS database
- ⏳ Use a foundation model in Amazon Bedrock (pending)

### Step 5: Complete Bedrock Activity (2 minutes)

**This is the only manual step:**

1. Go to [Amazon Bedrock Console](https://console.aws.amazon.com/bedrock)
2. Click **"Playgrounds"** in left menu
3. Click **"Chat"** or **"Text"**
4. Select any model:
   - Amazon Titan
   - Anthropic Claude
   - Meta Llama
   - AI21 Jurassic
5. Type a prompt: `"Hello, tell me about AWS"`
6. Click **"Run"** or **"Generate"**
7. ✅ **Done!**

**Cost:** ~$0.01-0.05 (covered by your credits)

### Step 6: Verify Credits Earned

1. Go to [AWS Console Home](https://console.aws.amazon.com)
2. Check **"Explore AWS"** widget
3. You should see: **"Activities completed: 5 of 5"**
4. **"Total credits earned: $100 of $100 USD"**

Credits appear within **24-48 hours** after completing activities.

### Step 7: Delete Resources (Important!)

**Once credits show up, DELETE the stack to avoid charges:**

```bash
aws cloudformation delete-stack --stack-name aws-credits-stack --region ap-south-1
```

Or in AWS Console:
1. Go to [CloudFormation Console](https://console.aws.amazon.com/cloudformation)
2. Select `aws-credits-stack`
3. Click **"Delete"**
4. Confirm deletion

**This removes:**
- EC2 instance (~$7.50/month)
- RDS database (~$12.24/month)
- Lambda function
- Security groups
- Secrets Manager secret

### Step 8: Keep Billing Protection (Recommended!)

**Deploy the billing alarm template for ongoing protection:**

```bash
aws cloudformation create-stack \
  --stack-name billing-protection \
  --template-body file://billing-alarm.yaml \
  --parameters \
    ParameterKey=EmailAddress,ParameterValue=your-email@example.com \
    ParameterKey=BudgetAmount,ParameterValue=10 \
    ParameterKey=BillingAlarmThreshold,ParameterValue=5 \
  --region ap-south-1
```

Or in AWS Console:
1. Go to [CloudFormation Console](https://console.aws.amazon.com/cloudformation)
2. Click **"Create stack"**
3. Upload `billing-alarm.yaml`
4. Enter your email and budget settings
5. Click **"Submit"**

**This keeps:**
- ✅ Monthly budget alerts
- ✅ Billing alarm (customizable threshold)
- ✅ Email notifications
- ✅ **Cost: $0.00** (completely free!)

**Protects your $100 credits from unexpected charges!**

---

## 💰 Cost Breakdown

| Resource | Monthly Cost | Free Tier |
|----------|--------------|-----------|
| EC2 t3.micro | ~$7.50 | 750 hrs/month (12 months) |
| RDS db.t3.micro | ~$12.24 | 750 hrs/month (12 months) |
| Lambda | ~$0.00 | 1M requests/month (always) |
| AWS Budgets | $0.00 | First 2 budgets free |
| CloudWatch Alarm | $0.00 | 10 alarms free |

**Total if within Free Tier:** $0.00  
**Total if left running:** ~$20/month

**Your $0.10 billing alarm protects you!**

---

## 🛡️ Billing Protection

The template includes multiple layers of protection:

1. **CloudWatch Billing Alarm** - Alerts at $0.10 spend
2. **AWS Budget** - Monthly budget with 80% and 100% alerts
3. **SNS Email Notifications** - Instant alerts to your email
4. **DeletionPolicy: Delete** - Clean removal of resources

**For Free Plan users:** No charges for 6 months!

---

## 📁 Repository Files

```
aws-free-tier-100-dollar-credits-cloudformation-template/
├── aws-credits-activities.yaml    # CloudFormation template (all 4 activities)
├── billing-alarm.yaml             # Budget protection only
├── deploy.sh                      # CloudFormation deployment script
├── iac-terraform/                 # Terraform configuration
│   ├── main.tf                    # Main Terraform config
│   ├── variables.tf               # Input variables
│   ├── outputs.tf                 # Output values
│   ├── terraform.tfvars.example   # Example variables
│   └── README.md                  # Terraform guide
├── README.md                      # This file
├── CONTRIBUTING.md                # Contribution guidelines
└── LICENSE                        # MIT License
```

**Choose your tool:**
- **CloudFormation** - Native AWS, no installation needed
- **Terraform** - Infrastructure as Code, multi-cloud support

---

## 🔧 Troubleshooting

### Stack creation fails

**Issue:** Template validation error  
**Solution:** Ensure you're using a supported region (ap-south-1, us-east-1, etc.)

**Issue:** Instance type not available  
**Solution:** Template uses t3.micro (Free Tier eligible in most regions)

**Issue:** MySQL version not found  
**Solution:** Template uses MySQL 8.0.40 (widely available)

### Activities not showing as complete

**Issue:** Activities still show "Not started"  
**Solution:** Wait 24-48 hours for AWS to process. Resources must be running.

**Issue:** Lambda not marked complete  
**Solution:** Visit the Lambda Function URL (check CloudFormation Outputs)

### Billing alarm not working

**Issue:** No email alerts  
**Solution:** 
1. Confirm SNS subscription in email
2. Check spam folder
3. Verify billing alerts enabled: AWS Console → Billing → Billing Preferences

### RDS creation takes long

**Issue:** Stack stuck on RDS creation  
**Solution:** RDS typically takes 10-15 minutes. Check CloudFormation Events tab.

---

## 🎓 What You'll Learn

By using this template, you'll understand:
- CloudFormation Infrastructure as Code
- AWS Budgets and cost management
- EC2 instance deployment
- Lambda serverless functions
- RDS database creation
- Security groups and IAM roles
- CloudWatch alarms and monitoring

---

## ⚠️ Important Notes

- **Free Plan credits expire:** 6 months from account creation OR when exhausted
- **Paid Plan credits expire:** 12 months from account creation (if you upgrade)
- **Free Plan account expires:** 6 months from account creation
- **One account only:** Credits available for one AWS account per person
- **Not for production:** This is for learning and earning credits
- **Monitor costs:** Always check your AWS billing dashboard
- **Delete resources:** Remove stack after earning credits

---

## 🤝 Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Ways to contribute:**
- Report bugs or issues
- Suggest improvements
- Add support for more regions
- Improve documentation
- Share your success story

---

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

## 💡 Pro Tips

1. **Deploy in your closest region** for better performance
2. **Set billing alarm low** ($0.10) to catch any unexpected charges
3. **Delete stack immediately** after credits appear
4. **Keep budget template** (`billing-alarm.yaml`) for ongoing protection
5. **Check credits regularly** in AWS Billing → Credits
6. **Use credits wisely** - Free Plan: 6 months, Paid Plan: 12 months
7. **Share this repo** to help others earn credits too!

---

## 🙏 Acknowledgments

This project helps new AWS users quickly earn their $100 in credits without manual setup. Built with ❤️ for the AWS community.

**Star ⭐ this repo if it helped you earn credits!**

---

## 📞 Support

- **Issues:** [GitHub Issues](https://github.com/om-mapari/aws-free-tier-100-dollar-credits-cloudformation-template/issues)
- **Discussions:** [GitHub Discussions](https://github.com/om-mapari/aws-free-tier-100-dollar-credits-cloudformation-template/discussions)
- **AWS Support:** [AWS Support Center](https://console.aws.amazon.com/support)

---

**Ready to earn your $100?** 🚀 [Get Started](#-quick-start-guide)
