---
title: "Automating NBA Game Notifications with AWS & Terraform"
date: 2025-02-02
description: "How I built an automated NBA game update notification system using AWS Lambda, SNS, and Terraform."
categories: ["Blog", "DevOps"]
tags: ["AWS", "Terraform", "Lambda", "SNS", "EventBridge", "Python"]
type: post
weight: 20
showTableOfContents: true
---

## 30 Days DevOps Challenge 🚀

As part of my **30 Days DevOps Challenge**, I recently completed my **NBA Game Updates Project**, an automation system that fetches NBA game updates and notifies subscribers via email. While working on this project, I wanted to challenge myself by deploying it with **Terraform**, making the setup fully automated and reproducible.

### 🔧 The Problem
Keeping up with NBA game updates in real-time can be tricky. Instead of manually checking scores, I wanted to automate the process so users could receive email notifications about game statuses.

### 💡 The Solution
I built a serverless solution using **AWS Lambda, SNS, and EventBridge**, with **Terraform** handling the infrastructure as code. The project:
- Fetches **NBA game data** from an external API.
- Uses **AWS Lambda** to process and format the data.
- Publishes game updates to an **AWS SNS topic**.
- Notifies **email subscribers** automatically.
- Is scheduled to run every **2 hours** via **EventBridge**.

### 🚀 Technologies Used
- **AWS Lambda** (Serverless function execution)
- **SNS** (Notification system for sending emails)
- **EventBridge** (Scheduled event triggers)
- **IAM** (Permission management)
- **Terraform** (Infrastructure as Code)
- **Python** (For Lambda function logic)

### 🔗 Read More & Try It Yourself
Want to see the full project details and learn how to deploy it yourself? Check out the full write-up here:

➡️ **[NBA Game Updates Project](/projects/nba_game_notification/)**

This project has been a great learning experience in **cloud automation and DevOps best practices**. Looking forward to more challenges ahead! 🚀

---

Stay tuned for more DevOps and Cloud projects as I continue my transition into **Cloud Engineering**! 💻

