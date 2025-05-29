---
title: "Automating NBA Game Notifications with AWS & Terraform"
date: "2025-01-16"
description: "My second project in the 30 Days DevOps Challenge, how I built an automated NBA game update notification system using AWS Lambda, SNS, and Terraform. "
tags: ["AWS", "Terraform", "Lambda", "SNS", "EventBridge ", "AWS 30 Days DevOps Challenge"]
type: post
weight: 20
showTableOfContents: true
---

### 🚀 Introduction

As part of my 30 Days DevOps Challenge, i completed my second project *NBA Game Updates*, an automated notification system for NBA game updates using AWS services. i chose to continue with AWS for its scalability and integration capabilities, and i decided to integrate Terraform in the mix to ensure consistent automatation in the infrastructure deployment.

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
- **Terraform:** Automates infrastructure deployment as code, creates the Lambda function, SNS, and all the policy.

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

## Prerequisites

Ensure you have:
- An AWS account.
- API keys for the NBA data provider.
- IAM roles with permissions for Lambda, SNS, and EventBridge.

## How It Works

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


### NBA Game Updates received from SNS

![Notification from SNS ](/images/nba_game_update.png)


### 🔮 Future Enhancements

To improve the project, I plan to:

- Add a retry mechanism for failed notifications – Ensures users don’t miss critical updates due to temporary delivery failures.
- Enable multi-channel alerts (SMS and mobile push notifications) – Expands accessibility beyond email, making notifications more immediate.
- Incorporate a user-friendly dashboard with AWS QuickSight – Provides real-time analytics and visualization of game updates for better user experience.

**🎯 Final Thoughts**

This project has been a valuable experience in building serverless solutions and deploying infrastructure with Terraform. I'm excited to tackle more cloud and DevOps challenges as I continue my journey into Cloud Engineering! 🚀

[🔗 Click here to access the project →](/projects/nba_game_notification/)
