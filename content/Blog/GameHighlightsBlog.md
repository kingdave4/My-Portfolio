---
title: "NCAA Game Highlights"
date: 2025-03-09T00:00:00Z
description: "A containerized pipeline that fetches NCAA game highlights using RapidAPI, processes videos with AWS MediaConvert, and provisions infrastructure with Terraform."
tags: ["AWS", "MediaConvert", "Terraform", "Docker", "RapidAPI", "DevOps"]
type: "post"
showTableOfContents: true
---

## Overview

When I started this project, my goal was simple: I wanted to build something fun, meaningful, and technically challenging. As a huge fan of Sport and i play basketball myself, I thought, *what if I could automatically pull NCAA game highlights and do something cool with them?* That curiosity led to the creation of **NCAA Game Highlights – Project #5**, an end-to-end pipeline that grabs game footage, processes it, and stores it—all powered by cloud tools.

## What This Project Does

* **Fetches Game Highlights:** I use a free Sports Highlights API via RapidAPI to pull in the latest NCAA basketball action.
* **Processes Video Clips:** Videos are downloaded and passed through AWS MediaConvert to get them into a web-friendly format.
* **Runs in a Docker Container:** Everything is packaged in a Docker container, so it works the same whether I run it on my laptop or in the cloud.
* **Automates Setup with Terraform:** I didn’t want to manually set up cloud resources every time, so I used Terraform to automate it all—S3 buckets, IAM roles, ECS, and more.
* **Keeps Secrets Safe:** Sensitive info like API keys is managed securely using AWS Secrets Manager.

## Tools I Used

* **Python 3** for scripting the logic
* **Docker** to containerize the workflow
* **Terraform** to provision cloud resources
* **AWS** for hosting, storing, and processing the videos
* **RapidAPI** to pull the game highlight data
* **AWS Secrets Manager** to handle sensitive credentials

### Architecture Diagram

![Diagram for the NCCA\_gamehighlight](/images/ncca_gamediagran.png)

## Project Layout

I organized the project into two main folders:

* `src/` – All the Python scripts, Dockerfile, and the `.env` config
* `terraform/` – Everything related to infrastructure setup

Here’s a quick look:

```bash
src/
├── fetch.py                # Pulls highlights from the API
├── mediaconvert_process.py # Sends video to AWS MediaConvert
├── run_all.py              # Glues everything together
├── Dockerfile              # Builds the container
└── .env                    # Stores config (not committed)

Terraform/
├── main.tf                 # Main Terraform file
├── iam.tf                  # IAM roles & permissions
├── s3.tf                   # S3 storage
└── terraform.tfvars        # Project-specific settings
```

## Getting Started

Before diving in, I needed a few things ready:

* A **RapidAPI account** to access the Sports Highlights API
* **AWS account** for cloud services
* **Docker & Python** installed locally

Then I added all my credentials and configuration in a `.env` file and pushed the RapidAPI key to AWS Secrets Manager.

```bash
aws secretsmanager create-secret \
    --name my-api-key \
    --secret-string '{"api_key":"YOUR_ACTUAL_API_KEY"}'
```

## Running It Locally

Once I had everything set, I built and ran the Docker container:

```bash
docker build -t highlight-processor .
docker run --env-file .env highlight-processor
```

It fetched NCAA highlights, processed one video, and saved it to my S3 bucket.

## Deploying to AWS

I wanted this pipeline to run in the cloud, so I used Terraform to provision everything:

```bash
cd terraform
terraform init
terraform apply -var-file="terraform.tfvars" -auto-approve
```

Then I built the Docker image, pushed it to ECR, and let ECS do the rest.

```bash
docker build -t highlight-pipeline .
docker tag highlight-pipeline:latest <aws_repo_url>
docker push <aws_repo_url>
```

## Lessons Learned

This project wasn’t without its bumps. My ECS service was stuck in a restart loop for a while, and MediaConvert refused to run jobs until I fixed IAM permissions. Debugging cloud services taught me a lot about reading logs and refining policies.

But in the end, seeing the processed game highlight show up in my S3 bucket was *incredibly satisfying*.

## What’s Next

I’m already thinking about improvements:

* Process multiple videos at once
* Use dynamic date ranges instead of static ones
* Add better logging and monitoring

## Final Thoughts

This was a super fun blend of my interests in sports and cloud engineering. Building something from scratch that actually works—and does something useful—is always rewarding.

