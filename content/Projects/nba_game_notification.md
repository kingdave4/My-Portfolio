---
title: "NBA Game Updates Project"
date: "2025-01-16"
description: "Automated NBA game notifications using AWS Lambda, SNS, and EventBridge with Terraform."
categories: ["Projects", "DevOps"]
tags: ["AWS", "Terraform", "Lambda", "SNS", "EventBridge", "Python"]
type: "post"
showTableOfContents: true
---

### 🌟 Project Overview
This project fetches real-time NBA game updates and delivers them to subscribers via email using AWS services. It leverages **AWS Lambda, SNS (Simple Notification Service), and EventBridge** for automation and notifications, with **Terraform** managing infrastructure as code.


### 🔧 Features
- Fetches **real-time NBA game data** using an external API.
- Publishes **formatted game updates** to an **AWS SNS topic**.
- Sends game updates to **email subscribers**.
- **Automates execution** using AWS **EventBridge**.

### 🏗️ Architecture Overview
![Project NBA Game update diagram](/images/Nbagame_notification_diagram.png)

#### Lambda Function:
- Fetches **NBA game data** from an external API.
- Formats the data based on game status (e.g., Scheduled, InProgress, Final).
- Publishes the updates to an **SNS topic**.

#### SNS Topic:
- **Acts as a message broker**, forwarding updates to subscribers (email-based in this case).

#### EventBridge:
- **Triggers the Lambda function** every **2 hours** to ensure timely updates.

#### IAM Roles and Policies:
- Securely grant the **Lambda function** permissions to publish to SNS and log data to CloudWatch.

### 🔗 Pre-Requisites
- **AWS account**
- **Terraform installed** on your local machine
- **API key** for the NBA game data provider (e.g., **SportsData.io**)

---
### 🏁 Setup Instructions
#### 1️⃣ Clone the Repository
```sh
git clone https://github.com/kingdave4/nba_game_notification_update.git
cd nba_game_notification_update
```

#### 2️⃣ Configure Environment Variables
Ensure the following variables are set in Terraform:
- `NBA_API_KEY`: Your API key for the NBA data provider.
- `SNS_TOPIC_ARN`: The ARN of the SNS topic for notifications.

#### 3️⃣ Update Email Subscription
Replace the email in the `aws_sns_topic_subscription` resource with your own:
```hcl
endpoint = "your-email@example.com"
```

#### 4️⃣ Deploy the Infrastructure
```sh
terraform init
terraform plan
terraform apply
```

#### 5️⃣ Confirm Email Subscription
Check your inbox and **confirm the SNS subscription** via the email link.

### 🔄 How It Works
1. **EventBridge** triggers the Lambda function **every 2 hours**.
2. **Lambda function**:
   - Fetches **game data** from the NBA API.
   - Formats the data and publishes it to **SNS**.
3. **SNS topic** sends updates to **subscribed emails**.

### 🗂️ Key Files
- `lambda/nba_game_lambda.zip` - **Python code** for the Lambda function.
- `main.tf` - **Terraform configuration** defining AWS resources.
- `variables.tf` - **Terraform variables** file.
- `outputs.tf` - **Outputs file**, including SNS topic ARN.

### 🛠️ Technologies Used
#### **AWS Services:**
- **Lambda** (Serverless function execution)
- **SNS** (Notification service for email updates)
- **EventBridge** (Scheduled event triggers)
- **IAM** (Permissions management)

#### **Other Tools:**
- **Terraform** (Infrastructure as Code - IaC)
- **Python** (Lambda function scripting)

---
### 🚀 Future Enhancements
- ✅ **Add support for SMS notifications** 📱
- ✅ **Implement filters** to customize updates for specific teams 🏀
- ✅ **Include error handling** for API failures and retries 🛠️
- ✅ **Integrate with a front-end dashboard** to display game updates in real-time 📊

### 🏆 Challenges I Overcame
1️⃣ **Lambda Timeout Issue**:
   - Fixed a **connection timeout** error by increasing execution time from **5 to 10 seconds**.

2️⃣ **SNS Recursive Loop**:
   - Resolved an **infinite loop** caused by incorrect permissions and configurations, ensuring a stable system.

### ⚠️ Troubleshooting
#### **No Emails Received?**
- ✅ Confirm the SNS subscription via the **email link**.
- ✅ Verify your email address in the `aws_sns_topic_subscription` resource.

#### **Errors in Lambda Execution?**
- ✅ Check **CloudWatch logs** for the Lambda function.
- ✅ Ensure the **NBA_API_KEY** is set correctly.

#### **Terraform Errors?**
- ✅ Verify **AWS credentials** are configured correctly.
- ✅ Run `terraform validate` to check for syntax issues.

This project showcases my ability to **automate cloud deployments** using **Terraform** and **leverage AWS services** to create a **fully automated NBA game update notification system**. More exciting projects coming soon! 🚀

---

### 📁 Repository

[GitHub - kingdave4/AzureDataLake](https://github.com/kingdave4/nba_game_notification_update.git)

---

### 📬 Contact

Feel free to reach out via [GitHub](https://github.com/kingdave4) if you have questions or suggestions!

---
