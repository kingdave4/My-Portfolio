---
title: "Containerized Sports API Management System"
date: 2025-01-17T00:00:00Z
description: "My third project in the 30 Days DevOps Challenge, a containerized API management system for querying real-time sports data using AWS ECS (Fargate), API Gateway, Docker, and Terraform."
tags: ["AWS", "ECS", "API Gateway", "Terraform", "Docker", "DevOps", "Python"]
type: "post"
showTableOfContents: true
---

## 📌 Overview

Welcome to my forth project in the DevOps Challenge, this project gave me a real-world experience and exposure to understand of how APIs, containers, and cloud infrastructure all work together in real-world applications. The **Containerized Sports API Management System** pushed me to explore more AWS services like ECS (Fargate), ECR, and API Gateway, all built with Terraform.


## 🛠️ Project Architecture

![Project NBA Game update diagram](/images/sportdiagram.png)


## What This Project Does

✅ **Fetches Sports Data**: Retrieves real-time sports data from the SerpAPI. 
✅ **Containerized Backend**: Runs a Flask API inside a Docker container. 
✅ **Deploys to AWS ECS (Fargate)**: Ensures a fully managed, serverless infrastructure. 
✅ **Exposes REST API**: Uses API Gateway to provide a secure endpoint. 
✅ **Monitors with CloudWatch**: Tracks API activity and logs errors.


## 🔧 Tools & Technologies

* **Python 3** for the app logic
* **Flask** for the web framework
* **Docker** for containerizing the app
* **AWS** (ECS, API Gateway, ECR, CloudWatch, IAM)
* **Terraform** for Infrastructure as Code

## Prerequisites

- Before you start, make sure you have:
- AWS Account: Sign up if you don’t have one.
- AWS CLI Installed: Configure AWS CLI with valid credentials.
- Terraform Installed: Used for provisioning AWS infrastructure.
- SerpAPI Key: Obtain an API Key from SerpAPI.
- Docker Installed: Required for building and running containers.

## ⚙️ AWS Services Breakdown

✅ ECR Reposiory: Stores the docker image in the cloud. 
✅ ECS Cluster: Runs the containerized Flask application. 
✅ ECS Task Definition: Defines CPU, memory, and environment settings. 
✅ ECS Service: Ensures the Flask API runs consistently. 
✅ Application Load Balancer: Routes traffic securely. 
✅ API Gateway: Exposes the API to external consumers. 
✅ CloudWatch Logs: Captures API logs for debugging and monitoring. 
✅ IAM Roles: Implements least-privilege access control. 
✅ Security Groups: Enforces secure network communication.


## 🤔 Challenges

* **IAM Permissions:** IAM roles and policies took time to get right, especially when attaching them to ECS tasks.
* **API Gateway Integration:** Took a bit of trial and error to properly wire up the API Gateway to ECS.
* **ECR Compatibility:** Ensuring the image build architecture matched what Fargate needed (`--platform linux/amd64`) tripped me up for a bit.


## 🎓 Lessons Learned

This project helped me:

* Understand how to write Terraform modules that are reusable and readable
* Get hands-on with ECS Fargate, which is surprisingly easy once you get past the initial learning curve
* Appreciate the value of logging and monitoring in production systems
* Realize the power of API Gateway to add a layer of abstraction and security


## 🎯 Future Plans

* Add a caching layer with ElastiCache for frequently requested data
* Store historical query data in DynamoDB
* Secure the API with keys or Cognito
* Add a CI/CD pipeline with GitHub Actions

## 🚮 Clean-Up Instructions

Don’t forget to clean up your resources when you’re done!

```bash
terraform destroy -var="sports_api_key=<Enter your SerpAPI key>" -auto-approve
```


[🔗 Click here to access the project →](/projects/containerized-sports-api/)