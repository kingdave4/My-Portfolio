---
title: "Containerized pipeline that fetches NCAA Game Highlights"
date: 2025-02-20T00:00:00Z
description: "A containerized pipeline that fetches NCAA game highlights using RapidAPI, processes videos with AWS MediaConvert, and provisions infrastructure with Terraform."
tags: ["AWS", "MediaConvert", "Terraform", "Docker", "RapidAPI", "DevOps"]
type: "post"
showTableOfContents: true
---

## Overview

**NCAA Game Highlights – Project #5** is a containerized pipeline designed to fetch NCAA game highlights via RapidAPI, process video content using AWS MediaConvert, and provision all required AWS infrastructure with Terraform. This project demonstrates a complete end-to-end solution combining Docker containerization, AWS services, and Infrastructure as Code (IaC).

## Project Features

- **RapidAPI Integration:** Accesses NCAA game highlights from a free-tier Sports Highlights API.
- **Video Processing:** Downloads video URLs from the API, stores metadata in S3, and uses AWS MediaConvert to transcode videos.
- **Containerized Pipeline:** Runs the entire workflow inside a Docker container for consistent deployments.
- **Terraform Automation:** Provisions AWS resources (VPC, S3, IAM, ECR, ECS, etc.) via Terraform.
- **Secure Configuration:** Manages sensitive keys and configurations using environment variables and AWS Secrets Manager.

## Tools & Technologies

- **Programming Language:** Python 3
- **Containerization:** Docker
- **Infrastructure as Code:** Terraform
- **Cloud Services:** AWS (S3, MediaConvert, ECS, IAM, ECR, CloudWatch, etc.)
- **API Integration:** RapidAPI (Sports Highlights API)
- **Secrets Management:** AWS Secrets Manager


### Project Archetectur diagrm
![Diagram for the NCCA_gamehighlight](/images/ncca_gamediagran.png)


## File Structure

```bash
src/
├── Dockerfile                # Instructions to build the Docker image
├── config.py                 # Loads environment variables with sensible defaults
├── fetch.py                  # Fetches NCAA highlights from RapidAPI and stores metadata in S3
├── mediaconvert_process.py   # Submits a job to AWS MediaConvert to process a video
├── process_one_video.py      # Downloads the first video from S3 JSON metadata and re-uploads it
├── run_all.py                # Orchestrates the execution of all scripts
├── requirements.txt          # Python dependencies for the project
├── .env                      # Environment variables (API keys, AWS credentials, etc.)
└── .gitignore                # Files to exclude from Git
terraform/
├── main.tf                   # Main Terraform configuration file
├── variables.tf              # Variables
├── secrets.tf                # AWS Secrets Manager and sensitive data provisioning
├── iam.tf                    # IAM roles and policies
├── ecr.tf                    # ECR repository configuration
├── ecs.tf                    # ECS cluster and service configuration
├── s3.tf                   # S3 bucket provisioning for video storage
├── container_definitions.tpl # Template for container definitions
├── terraform.tfvars          # Variables used in the Terraform configuration
└── outputs.tf                # Outputs from Terraform
```

## Prerequisites

Before getting started, ensure you have:

- **RapidAPI Account:** Sign up at [RapidAPI](https://rapidapi.com) and subscribe to the Sports Highlights API.
- **Docker Installed:** Verify with `docker --version`.
- **AWS CLI Installed:** Confirm installation with `aws --version` and configure with valid credentials.
- **Python 3 Installed:** Check with `python3 --version`.
- **AWS Account:** With valid IAM access keys and an AWS Account ID.

## Environment Configuration

#### 1. Create the `.env` File for Local Runs

In the project root (or within the `src` directory), create a file named `.env` and update the placeholder values:

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
DATE=2023-12-01
LEAGUE_NAME=NCAA
LIMIT=5
MEDIACONVERT_ENDPOINT=https://your_mediaconvert_endpoint_here.amazonaws.com
MEDIACONVERT_ROLE_ARN=arn:aws:iam::your_account_id:role/YourMediaConvertRole
INPUT_KEY=highlights/basketball_highlights.json
OUTPUT_KEY=videos/first_video.mp4
RETRY_COUNT=3
RETRY_DELAY=30
WAIT_TIME_BETWEEN_SCRIPTS=60
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

retry_count               = 5
retry_delay               = 60
```
Replace placeholder values with your actual configuration details.



## Setup & Deployment
### Local Development

#### 1. Clone the Repository:

``` bash
git clone https://github.com/kingdave4/NCAA_GamehighLight.git
cd NCAA_GamehighLight/src
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
docker run -d --env-file .env highlight-processor
```
The container will execute the pipeline: fetching highlights, processing a video, and submitting a MediaConvert job. 

Verify the output files in your S3 bucket (e.g., JSON metadata, raw videos, and processed videos).


### Deploying to AWS with Terraform

#### 1. Provision AWS Resources: Navigate to the terraform directory:

``` bash
cd terraform
terraform init
terraform validate
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars" -auto-approve

```
Terraform will provision the necessary AWS resources such as VPC, S3 bucket, IAM roles, ECR repository, ECS cluster, and more.

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

## Challenges & Troubleshooting
### Challenges Overcome
- ECS Task Restart Loop:
The ECS service was initially caught in a restart loop due to configuration or application errors. Adjustments in the task definitions and error handling resolved the issue.

- IAM PassRole Permission for MediaConvert:
ECS tasks encountered permission issues with AWS MediaConvert due to missing iam:PassRole permissions. This was fixed by refining IAM roles and policies.

### Troubleshooting Tips
- ECS Task Failures: Check the ECS console for stopped task reasons and exit codes to diagnose issues.

- MediaConvert Permission Errors: Ensure the IAM roles associated with ECS tasks include the necessary permissions, such as iam:PassRole.

## Key Takeaways
- Leveraged containerization (Docker) for a consistent and portable pipeline.
- Integrated multiple AWS services (S3, MediaConvert, ECS) to build a robust media processing workflow.
- Automated infrastructure provisioning using Terraform.
- Emphasized secure configuration management via environment variables and AWS Secrets Manager.

## Future Enhancements
- Expand Terraform scripts to provision additional AWS resources.
- Increase concurrent video processing capabilities.
- Transition from static date queries to dynamic time ranges.
- Improve logging and error handling for enhanced observability.

---

### 📁 Repository

[GitHub - kingdave4/AzureDataLake](https://github.com/kingdave4/NCAA_GamehighLight.git)

---

### 📬 Contact

Feel free to reach out via [GitHub](https://github.com/kingdave4) if you have questions or suggestions!

---
