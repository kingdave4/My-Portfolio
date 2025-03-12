---
title: "NCAA Game Data Backup (SportsDataBackup)"
date: 2025-03-09T00:00:00Z
description: "An evolved pipeline that fetches NCAA game highlights, backs up query data using AWS DynamoDB, and automates daily triggers with AWS EventBridge and ECS Fargate."
tags: ["AWS", "DynamoDB", "EventBridge", "ECS Fargate", "MediaConvert", "Terraform", "Docker", "DevOps"]
type: "post"
showTableOfContents: true
---

## 📌Overview

**NCAA Game Data Backup – Project #6: SportsDataBackup** is an evolution of the previous NCAA Game Highlights project. This upgrade enhances reliability and efficiency by integrating AWS DynamoDB for backing up query data and AWS EventBridge for daily automated triggers using ECS Fargate. The pipeline fetches game highlights via RapidAPI, processes videos with AWS MediaConvert, and provisions all necessary AWS infrastructure with Terraform—all while containerizing the workflow with Docker.

## Project Features

- **RapidAPI Integration:** Accesses NCAA game highlights via a free-tier API endpoint.
- **Data Backup & Storage:** 
  - **DynamoDB:** Securely backs up query data.
  - **S3:** Stores video metadata.
- **Event-Driven Automation:** Uses AWS EventBridge to schedule daily triggers, automating the entire workflow.
- **Video Processing:** Processes initial videos with AWS MediaConvert for optimal quality.
- **Containerized Pipeline:** Runs the complete workflow inside a Docker container.
- **Terraform Automation:** Provisions and manages AWS resources (VPC, S3, IAM, ECR, ECS, etc.) using Infrastructure as Code.
- **Secure Configuration:** Protects sensitive credentials via environment variables and AWS Secrets Manager.

## Tools & Technologies

- **Programming Language:** Python 3
- **Containerization:** Docker
- **Infrastructure as Code:** Terraform
- **Cloud Services:** AWS (DynamoDB, S3, MediaConvert, ECS Fargate, EventBridge, IAM, ECR, CloudWatch)
- **API Integration:** RapidAPI (Sports Highlights API)
- **Secrets Management:** AWS Secrets Manager

## Project Archetectur Diagram
![Diagram for the NCAA Game Data Backup](/images/ncca_gamebackup.png)


## File Structure
```bash
NCAAGameDataBackup/
├── src/
│   ├── Dockerfile                # Instructions to build the Docker image
│   ├── config.py                 # Loads environment variables with sensible defaults
│   ├── fetch.py                  # Fetches NCAA highlights from RapidAPI and stores metadata in S3
│   ├── mediaconvert_process.py   # Submits a job to AWS MediaConvert for video processing
│   ├── process_one_video.py      # Processes the first video from S3 metadata and re-uploads it
│   ├── run_all.py                # Orchestrates the execution of all scripts
│   ├── requirements.txt          # Python dependencies for the project
│   ├── .env                      # Environment variables (API keys, AWS credentials, etc.)
│   └── .gitignore                # Files to exclude from Git
├── terraform/
│   ├── main.tf                   # Main Terraform configuration file
│   ├── variables.tf              # Variable definitions
│   ├── secrets.tf                # AWS Secrets Manager and sensitive data provisioning
│   ├── dynamodb.tf               # DynamoDB table configuration
│   ├── eventbridge.tf            # EventBridge rules and configuration
│   ├── iam.tf                    # IAM roles and policies
│   ├── ecr.tf                    # ECR repository configuration
│   ├── ecs.tf                    # ECS cluster and service configuration
│   ├── s3.tf                     # S3 bucket provisioning for video storage
│   ├── container_definitions.tpl # Template for container definitions
│   ├── terraform.tfvars          # Variables for the Terraform configuration
│   └── outputs.tf                # Terraform outputs
└── README.md                     # Project documentation
```

## Prerequisites

Before getting started, ensure you have:

- **RapidAPI Account:** Sign up at [RapidAPI](https://rapidapi.com) and subscribe to the Sports Highlights API.
- **Docker Installed:** Verify with `docker --version`.
- **AWS CLI Installed:** Confirm installation with `aws --version` and configure with valid credentials.
- **Python 3 Installed:** Check using `python3 --version`.
- **AWS Account Details:** Your AWS Account ID and valid IAM access keys.

## Environment Configuration

### 1. Create the `.env` File for Local Runs

In the project root (or within the `src` directory), create a file named `.env` and update the placeholder values with your credentials and configuration details:

```dotenv
# .env

API_URL=https://sport-highlights-api.p.rapidapi.com/basketball/highlights
RAPIDAPI_HOST=sport-highlights-api.p.rapidapi.com
RAPIDAPI_KEY=your_rapidapi_key_here
AWS_ACCESS_KEY_ID=your_aws_access_key_id_here
AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key_here
AWS_DEFAULT_REGION=us-east-1
S3_BUCKET_NAME=your_S3_bucket_name_here
AWS_REGION=us-east-1
LEAGUE_NAME=NCAA
LIMIT=10
MEDIACONVERT_ENDPOINT=https://your_mediaconvert_endpoint_here.amazonaws.com
MEDIACONVERT_ROLE_ARN=arn:aws:iam::your_account_id:role/YourMediaConvertRole
INPUT_KEY=highlights/basketball_highlights.json
OUTPUT_KEY=videos/first_video.mp4
RETRY_COUNT=3
RETRY_DELAY=30
WAIT_TIME_BETWEEN_SCRIPTS=60
DYNAMODB_TABLE=your_dynamodb_table_name_here
```

### 2. Create the terraform.tfvars File
Within the terraform directory, create a file named terraform.tfvars and update it with your configuration:

```t
# terraform.tfvars

aws_region                = "us-east-1"
project_name              = "your_project_name_here"
s3_bucket_name            = "your_S3_bucket_name_here"
ecr_repository_name       = "your_ecr_repository_name_here"

rapidapi_ssm_parameter_arn = "arn:aws:ssm:us-east-1:xxxxxxxxxxxx:parameter/myproject/rapidapi_key"

mediaconvert_endpoint     = "https://your_mediaconvert_endpoint_here.amazonaws.com"
mediaconvert_role_arn     = "" 
# Optionally, specify your custom MediaConvert role ARN here.

retry_count               = 3
retry_delay               = 60
```
Replace placeholder values with your actual configuration details.

## Setup & Deployment
### Local Development

#### 1. Clone the Repository:
``` bash
git clone https://github.com/kingdave4/NCAAGameDataBackup.git
cd NCAAGameDataBackup
```

#### 2. Add Your API Key to AWS Secrets Manager: Store your RapidAPI key securely

``` bash
aws secretsmanager create-secret \
    --name my-api-key \
    --description "API key for accessing the Sports Highlights API" \
    --secret-string '{"api_key":"YOUR_ACTUAL_API_KEY"}' \
    --region us-east-1
```

#### 3. Update File Permissions: Secure your .env file:
``` bash
chmod 600 .env
```

#### 4. Build & Run the Docker Container:

``` bash
docker build -t highlight-processor .
docker run --env-file .env highlight-processor
```

The container executes the pipeline—fetching highlights, backing up query data, processing a video, and submitting a MediaConvert job. 
Verify the output in your S3 bucket and DynamoDB table.


### Deploying to AWS with Terraform

#### 1. Provision AWS Resources: Navigate to the terraform directory:

``` bash
cd terraform
terraform init
terraform validate
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars" -auto-approve
```
Terraform will provision all necessary AWS resources, including VPC, S3 bucket, DynamoDB table, IAM roles, ECR repository, ECS cluster, EventBridge rules, and more.

#### 2. Deploy Docker Image to AWS ECR:

``` bash
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com

docker build -t highlight-pipeline:latest .
docker tag highlight-pipeline:latest <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/highlight-pipeline:latest
docker push <AWS_ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/highlight-pipeline:latest
```

#### 3. Clean-Up: When needed, remove all provisioned AWS resources:
``` bash
terraform destroy -auto-approve
```


## Key Takeaways
- Containerization: Docker ensures a consistent and portable deployment environment.
- AWS Integration: The pipeline fetches NCAA game highlights, backs up query data in DynamoDB, and processes videos with MediaConvert.
- Event-Driven Automation: AWS EventBridge schedules daily triggers, while ECS Fargate runs containerized tasks without server management.
- Infrastructure as Code: Terraform automates the provisioning and management of AWS resources.
- Secure Configuration: Environment variables and AWS Secrets Manager protect sensitive data.

## Future Enhancements
- Expand Terraform scripts to provision additional AWS resources.
- Increase the number of videos processed concurrently.
- Transition from static date queries to dynamic time ranges (e.g., last 30 days).
- Enhance logging and error handling for better observability.