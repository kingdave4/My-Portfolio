---
title: "Containerized Sports API Management System"
date: 2025-02-10T00:00:00Z
description: "A containerized API management system for querying real-time sports data using AWS ECS (Fargate), API Gateway, Docker, and Terraform."
tags: ["AWS", "ECS", "API Gateway", "Terraform", "Docker", "DevOps", "Python"]
type: "post"
showTableOfContents: true
---

## 📌 Overview

This project was born out of my curiosity to better understand how APIs, containers, and cloud infrastructure all work together in real-world applications. The **Containerized Sports API Management System** is my fourth DevOps Challenge, and it pushed me to explore AWS ECS (Fargate), API Gateway, and Terraform much more deeply than I had before.

It was a fun (and sometimes frustrating) project that ended with a fully functioning, serverless, and secure API system for fetching real-time sports data.

## 🏗️ Project Motivation

I love sports and I love tech. I thought, why not bring them together in a way that also sharpens my cloud and DevOps skills? The goal was to containerize a lightweight Python API that interacts with SerpAPI, deploy it to AWS using Fargate, and expose it through API Gateway so it could be consumed easily from anywhere.

## 🛠️ Project Architecture

![Project NBA Game update diagram](/images/sportdiagram.png)

The system has a few key moving parts:

* A **Flask app** that talks to SerpAPI
* A **Docker container** running that app
* An **ECR repo** to store the image
* A **Fargate service** that runs the container on AWS ECS
* An **API Gateway** endpoint that exposes the app to the outside world
* **CloudWatch Logs** to track what's happening under the hood

Everything is spun up using Terraform.

## 📈 Key Features

* Real-time sports data retrieval from SerpAPI
* Containerized Python backend with Flask
* Deployment via ECS Fargate (serverless)
* RESTful API exposed via API Gateway
* Full observability via CloudWatch

## 🔧 Tools & Technologies

* **Python 3** for the app logic
* **Flask** for the web framework
* **Docker** for containerizing the app
* **AWS** (ECS, API Gateway, ECR, CloudWatch, IAM)
* **Terraform** for Infrastructure as Code

## 🎓 Lessons Learned

This project helped me:

* Understand how to write Terraform modules that are reusable and readable
* Get hands-on with ECS Fargate, which is surprisingly easy once you get past the initial learning curve
* Appreciate the value of logging and monitoring in production systems
* Realize the power of API Gateway to add a layer of abstraction and security

## 🤔 Challenges

* **IAM Permissions:** IAM roles and policies took time to get right, especially when attaching them to ECS tasks.
* **API Gateway Integration:** Took a bit of trial and error to properly wire up the API Gateway to ECS.
* **ECR Compatibility:** Ensuring the image build architecture matched what Fargate needed (`--platform linux/amd64`) tripped me up for a bit.

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

