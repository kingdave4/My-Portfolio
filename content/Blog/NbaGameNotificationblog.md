---
title: "Automating NBA Game Notifications with AWS & Terraform"
date: "2025-01-21"
description: "How I built an automated NBA game update notification system using AWS Lambda, SNS, and Terraform."
categories: ["Blog", "DevOps"]
tags: ["AWS", "Terraform", "Lambda", "SNS", "EventBridge ", "30 Days DevOps Challenge"]
type: post
weight: 20
showTableOfContents: true
---

*A deep dive into my NBA Game Updates Project, automating notifications using AWS Lambda, SNS, and Terraform.*  

---

### 🚀 Introduction

As part of my 30 Days DevOps Challenge, I completed my *NBA Game Updates Project*, an automated notification system for NBA game updates using AWS services. I chose AWS for its scalability and integration capabilities, and I used Terraform to ensure automated, consistent, and reproducible infrastructure deployment.

### Project architecture diagram

![Project NBA Game update diagram](/images/Nbagame_notification_diagram.png)


### 🏀 What This Project Does

This project automates NBA game update notifications by:

- **Fetching NBA Data** – Retrieves real-time game data from an external API.
- **Processing Data with Lambda** – Uses AWS Lambda to format and process the updates.
- **Sending Notifications via SNS** – Publishes updates to an AWS SNS topic for email alerts.
- **Scheduling with EventBridge** – Runs every 2 hours through AWS EventBridge triggers.

### 🛠️ Tools and Technologies Used

- **Programming Language:** Python – For processing NBA game updates within the Lambda function.
- **AWS Lambda:** Executes the Python script to fetch, process, and send notifications.
- **AWS SNS (Simple Notification Service):** Manages pub-sub messaging and sends email alerts to subscribers.
- **AWS EventBridge:** Creates scheduled triggers to run the Lambda function every 2 hours.
- **AWS IAM (Identity and Access Management):** Manages permissions and access control for AWS services.
- **Terraform:** Automates infrastructure deployment as code, ensuring consistency and reproducibility.

### 📝 Setup Instructions

#### Project Structure
Here is how the project is organized:

### File Structure of nba_game_notification_update

```plaintext
nba_game_notification_update/
├── lambda/
│   └── nba_game_lambda.zip      # Contains the Python code for the Lambda function.
|   └── requirements.txt         # Required packeges needed to run the python code
├── terraform/
│   ├── main.tf                  # Terraform configuration defining AWS resources.
│   ├── variables.tf             # Terraform variables file.
|   ├── provider.tf              # Terraform provider and region
│   └── outputs.tf               # Outputs such as the SNS topic ARN.
├── .gitignore                   # Specifies intentionally untracked files.
└── README.md                    # Project documentation and setup instructions.
```

### Main Terraform Configuration for the NBA Game Updates Project

```hcl
# Creates an IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "nba_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach the AWS managed policy for Lambda execution
resource "aws_iam_role_policy" "lambda_policy" {
  name   = "nba_lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow",
        Action   = ["sns:Publish"],
        Resource = aws_sns_topic.nba_topic.arn
      }
    ]
  })
}

# Create Lambda function
resource "aws_lambda_function" "nba_lambda" {
  function_name = "nba_game_data_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"

  # Path to your Lambda deployment package (ZIP file with the Python code)
  filename = "../lambda/nba_game_lambda.zip"

  # Set the environment variables
  environment {
    variables = {
      NBA_API_KEY   = var.nba_api_key
      SNS_TOPIC_ARN = aws_sns_topic.nba_topic.arn
    }
  }
}

# Create SNS Topic for NBA Game Updates
resource "aws_sns_topic" "nba_topic" {
  name = "nba_game_updates"
}

# The ARN of the SNS topic to which game updates are published.
# Used in the Lambda function to send updates.
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.nba_topic.arn
  protocol  = "email"
  endpoint  = "kingofcloud13@gmail.com" # Replace with the desired email address
}

# Lambda Permission for EventBridge
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.nba_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule_rule.arn
}

# EventBridge Rule to trigger Lambda every 2 hours
resource "aws_cloudwatch_event_rule" "schedule_rule" {
  name                = "nba_game_update_schedule"
  description         = "Schedule to trigger Lambda every 2 hours"
  # This cron expression triggers the Lambda function every 2 hours.
  # Format: (minute, hour, day, month, weekday).
  schedule_expression = "cron(0 */2 * * ? *)"
}

# EventBridge Target to trigger Lambda
resource "aws_cloudwatch_event_target" "schedule_target" {
  rule      = aws_cloudwatch_event_rule.schedule_rule.name
  target_id = "nba_lambda"
  arn       = aws_lambda_function.nba_lambda.arn
}

```
## Step 1: Prerequisites

Ensure you have:
- An AWS account.
- API keys for the NBA data provider.
- IAM roles with permissions for Lambda, SNS, and EventBridge.

### Step 2: How It Works

The project structure includes a Terraform configuration and a Python script:

- **Terraform**: Provisions AWS resources (Lambda, SNS, EventBridge, IAM roles).
- **Python Script**: Processes game data and publishes notifications via SNS.

### 🏗️ Order of Execution

1. **Create an SNS Topic** – For email notifications.
2. **Deploy Lambda Function** – Processes game data and sends alerts.
3. **Configure EventBridge Rule** – Triggers Lambda every 2 hours.
4. **Subscribe Users to SNS** – Adds email subscribers for updates.

### 🛡️ Monitoring with CloudWatch

To monitor the workflow, AWS CloudWatch is integrated for logging all activities. CloudWatch collects and stores logs from services like Lambda and EventBridge automatically.

### How CloudWatch Integrates with Lambda:

- When the Lambda function runs, CloudWatch captures logs from the execution.
- It tracks metrics such as duration, errors, and invocation count.


### Example CloudWatch Log Entry

![Cloudwatch log](/images/cloudwatch_nba.png)
 

This visibility helps with performance optimization and troubleshooting.

### 🌟 Lessons Learned

This project enhanced my cloud automation and DevOps skills, teaching me:

- How to automate infrastructure with Terraform.
- How to build event-driven architectures with AWS services.
- The importance of logging and monitoring with CloudWatch.

**Challenges Faced and How I Overcame Them:**

- **Issue:** No Emails Received.
  
  **Solution:** 
  - Ensure you confirmed the SNS subscription via the email link.
  - Verify the email address in the aws_sns_topic_subscription resource.

- **Issue:** Errors in Lambda Execution.

  **Solution:** 
  - Check the CloudWatch logs for the Lambda function
  - Verify that the NBA_API_KEY is correctly set and valid.


#### NBA Game Updates received from SNS

![Notification from SNS ](/images/nba_game_update.png)


### 🔮 Future Enhancements

To improve the project, I plan to:

- Add a retry mechanism for failed notifications – Ensures users don’t miss critical updates due to temporary delivery failures.
- Enable multi-channel alerts (SMS and mobile push notifications) – Expands accessibility beyond email, making notifications more immediate.
- Incorporate a user-friendly dashboard with AWS QuickSight – Provides real-time analytics and visualization of game updates for better user experience.

### 🎯 Final Thoughts

This project has been a valuable experience in building serverless solutions and deploying infrastructure with Terraform. I'm excited to tackle more cloud and DevOps challenges as I continue my journey into Cloud Engineering! 🚀

🔗 **GitHub Repository:** [nba_game_notification_update](https://github.com/kingdave4/nba_game_notification_update.git)
