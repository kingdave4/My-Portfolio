---
title: "Building My Cloud Portfolio with Hugo, Terraform, and Azure"
date: 2025-05-25
description: "A fully automated, cloud-native walkthrough of deploying my personal portfolio and blog on Azure using IaC and CI/CD."
tags: [cloud, devops, azure, terraform, hugo, github-actions, portfolio]
type: "post"
showTableOfContents: true
---

## Overview

This project is a fully automated, cloud-native portfolio and blog platform built using **Hugo**, **Terraform modules**, **GitHub Actions**, and **Microsoft Azure**. It serves as a live demonstration of my expertise in Infrastructure as Code (IaC), CI/CD pipelines, serverless backend development, and secure cloud deployments.

It hosts my portfolio, blog posts, resume, and contact form, and it's entirely provisioned and managed via Terraform and GitHub Actions.

---

## 🔧 Tools & Technologies

* **Hugo**: Static site generator for creating the blog and portfolio.
* **Terraform (modular)**: Used to provision Azure infrastructure using reusable modules.
* **Azure Static Web Apps**: Hosts the frontend Hugo site with global scalability.
* **Azure Function App (Python)**: Backend logic for contact form and future API endpoints.
* **Azure Blob Storage**: Static website hosting for downloadable resume.
* **Azure Key Vault**: Manages API keys and other sensitive secrets.
* **Application Insights**: Provides monitoring, metrics, and diagnostics.
* **GitHub Actions**: Automates CI/CD pipeline for both frontend and backend deployments.

---

## 🧱 Infrastructure Diagram

![Diagram for the portfolio](/images/myhugoportofolio.png)

---

## 💻 Project Structure

```
My-Portfolio/
├── terraform/                    # Terraform configuration
│   ├── environments/dev/         # Development environment
│   ├   ├── backend.tf                  # Backend configuation - Tfstate file configuration 
│   ├   ├── main.tf                  # Module main reusable file
│   ├   ├── provider.tf                # Reusable Terraform modules
│   ├   ├── variable.tf                 # Variable file
│   ├   ├── terraform.tfvars                 # default variable file
│   ├── modules/                  # Reusable Terraform modules
│   │   ├── resource-group/       # Azure resource group for all the services
│   │   ├── static-web-app/       # Deploys Hugo to Azure Static Web App
│   │   ├── function-app/         # Azure Function deployment
│   │   ├── blob-storage/         # Resume static hosting
│   │   ├── monitoring/           # App Insights integration
│   │   └── key-vault/            # Secrets management
├── hugo-site/                    # Hugo source content
│   ├── config.toml               # Site configuration
│   └── content/, themes/, etc.   # Blog and portfolio content
├── azure-functions/             # Python Azure Function code
│   ├── contact_form/             # Logic for contact form
│   └── requirements.txt          # Python dependencies
├── .github/workflows/
│   └── deploy.yml               # GitHub Actions workflow
```

---

## 🚀 Deployment Guide

### 1. Clone Repository

```bash
git clone https://github.com/kingdave4/My-Portfolio.git
cd My-Portfolio
```

### 2. Configure Secrets

Add your variables to a `.tfvars` file or securely pass them via Terraform Cloud or GitHub Secrets. Required values:

```hcl
subscription_id = "<YOUR_AZURE_SUBSCRIPTION_ID>"
function_name   = "<AZURE_FUNCTION_NAME>"
storage_name    = "<STORAGE_ACCOUNT_NAME>"
sendgrid_api_key= "<SENDGRID_API_KEY>"
```

### 3. Provision Infrastructure

```bash
cd terraform
terraform init
terraform plan -var-file="secrets.tfvars"
terraform apply -var-file="secrets.tfvars" -auto-approve
```

### 4. Run Hugo Locally

```bash
cd hugo-site
hugo server -D
```

### 5. GitHub Actions Deployment

Pushing changes to the `main` branch triggers the GitHub Actions workflow to:

* Build the Hugo static site
* Deploy the frontend to Azure Static Web Apps
* Deploy the backend Python Azure Function

Ensure required GitHub secrets (e.g., Azure credentials, SendGrid key) are added to the repo settings.

---

## 🔁 How It Works

1. **Local Development**: Designed and tested the site locally using Hugo.
2. **Version Control**: Pushed changes to GitHub with version tracking.
3. **CI/CD Pipeline**: Unified GitHub Actions workflow handles:

   * Hugo site build
   * Static Web App deployment
   * Azure Function deployment
4. **Infrastructure Provisioning**:

   * Static Web App (via Terraform module)
   * Azure Function App (Python) + Service Plan
   * Blob Storage with `$web` container for resume
   * Azure Key Vault for managing secrets
   * Application Insights for telemetry
5. **Resume Hosting**: PDF resume served from Blob Storage via static web endpoint.

---

## 📬 Contact Form Logic

* Frontend form on the site triggers an HTTP request
* Azure Function (Python) receives and processes form data
* Sends email using SendGrid API via secret stored in Azure Key Vault
* Logs success/failure using Application Insights

---

## 📁 Repository

[GitHub - kingdave4/My-Portfolio](https://github.com/kingdave4/My-Portfolio.git)

---

## 📬 Contact

For questions, feedback, or opportunities, feel free to [connect on LinkedIn](https://www.linkedin.com/in/david-mboli-idie-38b974209/) or drop me a message through the contact form.


