title: "NCAA Game Data Backup (SportsDataBackup)"
date: "2025-03-09"
Tags: AWS, DynamoDB, EventBridge, ECS Fargate, MediaConvert, Terraform, Docker, DevOps
description: "A containerized pipeline that fetches NCAA game highlights using RapidAPI, processes videos with AWS 
type: post
showTableOfContents: true
weight: 20
---

## 📌 Overview

Welcome to my Devops Challenge project #6: **NCAA Game Data Backup – SportsDataBackup**, this project is designed to evolve and enhance a previous workflow I created for collecting NCAA basketball game highlights. This version improves automation, resilience, and cloud-native architecture by integrating AWS DynamoDB for query data backups, AWS EventBridge for scheduling, and ECS Fargate for scalable container execution.

In essence, this project automates the fetching of game highlight data via RapidAPI, processes the associated videos with AWS MediaConvert, and securely manages infrastructure using Docker and Terraform.

It's a fully containerized and event-driven data pipeline designed with production-level practices in mind all built and maintained by me.

---

## 🔧 Features at a Glance

* **RapidAPI Integration:** Pulls NCAA basketball game highlights from a third-party API.
* **Data Backup:**
  * **DynamoDB:** Backs up API query metadata for resilience.
  * **S3:** Stores video metadata and output.
* **Daily Automation:**
  * Scheduled tasks run daily via **AWS EventBridge**.
  * Containers are executed in **ECS Fargate** no servers to manage.
* **Video Processing:** Converts highlight videos into optimized formats with **AWS MediaConvert**.
* **Infrastructure as Code:** All AWS resources are provisioned with **Terraform**.
* **Security:** Sensitive data is protected using **AWS Secrets Manager** and `.env` configurations.
* **Portability:** The entire workflow runs in a **Docker container** for consistency across environments.

---

## 🧰 Tech Stack

| Category               | Tools / Services                            |
| ---------------------- | ------------------------------------------- |
| **Language**           | Python 3                                    |
| **API Integration**    | RapidAPI (Sports Highlights API)            |
| **Cloud Services**     | AWS (DynamoDB, S3, MediaConvert, ECS, etc.) |
| **Infrastructure**     | Terraform                                   |
| **Containerization**   | Docker                                      |
| **Secrets Management** | AWS Secrets Manager                         |
| **Automation**         | AWS EventBridge + ECS Fargate               |

---

## 📊 Architecture Diagram

![Architecture diagram for NCAA Game Data Backup](/images/ncca_gamebackup.png)

---

## 📁 Project Structure

```bash
NCAAGameDataBackup/
├── src/                  # Core Python scripts and Dockerfile
├── terraform/            # Terraform modules for AWS infrastructure
└── README.md             # Project overview and setup guide
```

Highlights of key components:

* `fetch.py`: Grabs highlights and stores metadata in S3
* `mediaconvert_process.py`: Processes videos using MediaConvert
* `dynamodb.tf`, `eventbridge.tf`, `ecs.tf`: Automate AWS provisioning
* `.env`: Manages runtime secrets for local development
* `run_all.py`: Orchestrates the entire pipeline

---

## 🚀 Getting Started

### ✅ Prerequisites

* [ ] AWS CLI installed and configured
* [ ] Docker installed
* [ ] Python 3
* [ ] Terraform installed
* [ ] A RapidAPI account (Sports Highlights API)
* [ ] Valid AWS credentials

---

### 1️⃣ Local Development

Clone the repo:

```bash
git clone https://github.com/kingdave4/NCAAGameDataBackup.git
cd NCAAGameDataBackup
```

Secure your API key in AWS Secrets Manager:

```bash
aws secretsmanager create-secret \
  --name my-api-key \
  --description "API key for accessing the Sports Highlights API" \
  --secret-string '{"api_key":"YOUR_ACTUAL_API_KEY"}' \
  --region us-east-1
```

Create a `.env` file in the `src/` directory with your configuration:

```dotenv
RAPIDAPI_KEY=your_api_key
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret
...
```

Then build and run the container:

```bash
docker build -t highlight-processor .
docker run --env-file .env highlight-processor
```

---

### 2️⃣ Deploy to AWS with Terraform

Navigate to the Terraform directory:

```bash
cd terraform
terraform init
terraform apply -var-file="terraform.tfvars" -auto-approve
```

Then push your Docker image to AWS ECR:

```bash
docker build -t highlight-pipeline:latest .
docker tag highlight-pipeline:latest <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/highlight-pipeline
docker push <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/highlight-pipeline
```

Now, your automated daily video processing is fully live on AWS.

---

## 🔍 Key Takeaways

* **Event-Driven:** EventBridge and ECS Fargate work together to automate daily runs.
* **Resilient Data Storage:** DynamoDB and S3 ensure no loss of metadata.
* **Secure by Design:** Credentials and secrets are never hardcoded.
* **Infrastructure as Code:** Terraform enables reproducible, scalable deployments.
* **Containerized Workflow:** Docker brings consistency across dev and prod.

---

## 📊 What's Next?

Planned future improvements:

* Add support for concurrent video processing
* Dynamically query highlights based on rolling time ranges
* Expand Terraform provisioning (e.g., API Gateway, Lambda)
* Enhance logging and alerting with CloudWatch


[🔗 Click here to access the project →](/projects/ncaa-game-data-backup/)