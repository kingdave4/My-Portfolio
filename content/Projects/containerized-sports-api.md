---
title: "Containerized Sports API Management System"
date: 2025-03-09T00:00:00Z
description: "A containerized API management system for querying real-time sports data using AWS ECS (Fargate), API Gateway, Docker, and Terraform."
tags: ["AWS", "ECS", "API Gateway", "Terraform", "Docker", "DevOps", "Python"]
type: "post"
image: "/images/sportdiagram.png"
showTableOfContents: true
---

## 📌 Overview

The **Containerized Sports API Management System** is built as part of DevOpsChallenge #4. This project provides a scalable, serverless, and secure solution for querying real-time sports data. It leverages AWS services such as Amazon ECS (Fargate) for container orchestration, API Gateway to expose RESTful endpoints, and CloudWatch for monitoring, while automating infrastructure deployment with Terraform.

[View on GitHub](https://github.com/kingdave4/Containerized-Sports-Api.git)

### 🏗️ Architecture Overview

![Project NBA Game update diagram](/images/sportdiagram.png)


## Project Features

- **Fetches Sports Data:** Retrieves real-time sports data from SerpAPI.
- **Containerized Backend:** Runs a Flask API inside a Docker container.
- **Deploys to AWS ECS (Fargate):** Ensures a fully managed, serverless container infrastructure.
- **Exposes REST API:** Uses Amazon API Gateway to provide secure endpoints.
- **Monitors with CloudWatch:** Tracks API activity and logs errors for troubleshooting.

## Tools & Technologies

- **Programming Language:** Python 3.x
- **Cloud Provider:** AWS
- **Core AWS Services:** ECR, ECS (Fargate), API Gateway, CloudWatch
- **Containerization:** Docker
- **Infrastructure as Code:** Terraform
- **Security:** IAM roles and security groups

## Prerequisites

Before getting started, ensure you have:

- **AWS Account:** Sign up if you don’t have one.
- **AWS CLI Installed:** Configure the AWS CLI with valid credentials.
- **Terraform Installed:** For provisioning AWS infrastructure.
- **SerpAPI Key:** Obtain an API key from [SerpAPI](https://serpapi.com).
- **Docker Installed:** Required for building and running containers.

## Deployment Guide

1. **Clone the Repository:**
```bash
   git clone https://github.com/kingdave4/Containerized-Sports-Api.git
   cd containerized-sports-api
```

2. **Create ECR Repository:**

``` bash
aws ecr create-repository --repository-name sports-api --region us-east-1
```

3. **Authenticate, Build, and Push the Docker Image:**

``` bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com

docker build --platform linux/amd64 -t sports-api .
docker tag sports-api:latest <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/sports-api:sports-api-latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/sports-api:sports-api-latest
```

4. **Deploy Infrastructure Using Terraform:**

``` bash
cd terraform
terraform init
terraform plan -var="sports_api_key=<Enter your SerpAPI key>"
terraform apply -var="sports_api_key=<Enter your SerpAPI key>" -auto-approve
```

### Retrieve API Gateway Endpoint**: 
After deployment, Terraform will output the API Gateway URL. Use this endpoint to test your API.

![APIgatewayURL](/images/apigateway.png)

## Project Structure

``` bash
containerized-sports-api/
├── app.py                  # Flask application for querying sports data
├── Dockerfile              # Dockerfile to containerize the Flask app
├── requirements.txt        # Python dependencies
├── terraform/              # Terraform configuration files
├── .dockerignore           # Docker ignore file
├── .gitignore              # Git ignore file
└── README.md               # Project documentation
```

## AWS Services Breakdown

- ECR Repository: Stores the Docker image in the cloud.
- ECS Cluster & Service: Runs the containerized Flask application on Fargate.
- Task Definition: Defines CPU, memory, and environment settings.
- Application Load Balancer: Routes traffic securely.
- API Gateway: Exposes the API to external consumers.
- CloudWatch Logs: Captures logs for debugging and monitoring.
- IAM Roles & Security Groups: Enforce secure access and network communication.


## What I Learned

- Automated Infrastructure Provisioning: Gained hands-on experience with Terraform to provision AWS resources like ECS, API Gateway, and Load Balancer.
- Containerized Deployment: Learned how to deploy and manage containerized applications with Amazon ECS (Fargate).
- API Gateway Integration: Set up API Gateway to securely expose RESTful endpoints.
- Docker Image Management: Managed Docker images using Amazon ECR.


Future Enhancements
- Add Caching: Integrate Amazon ElastiCache for frequently requested data.
- Implement DynamoDB: Use DynamoDB to store user-specific API queries.
- Enhance API Security: Implement API Keys or IAM authentication for API Gateway.
- CI/CD Pipelines: Automate deployment with GitHub Actions for continuous integration and delivery.


## Clean-Up Instructions

To remove all AWS resources provisioned by Terraform, run:

``` bash
terraform destroy -var="sports_api_key=<Enter your SerpAPI key>" -auto-approve
```

## 📁 Repository

[GitHub - kingdave4/AzureDataLake](https://github.com/kingdave4/Nba_Data_Lake)

---

## 📬 Contact

Feel free to reach out via [GitHub](https://github.com/kingdave4) if you have questions or suggestions!

---

