---
layout: post
title: "Building BetaTask‑Solutions: Why We Chose Kubernetes on Azure"
date: 2025-06-27
description: "A deep dive into the architectural decisions, challenges, and lessons learned while provisioning Kubernetes infrastructure for BetaTask‑Solutions on Azure."
tags: [azure, devops, aks, acr, terraform, github-actions, prometheus, grafana, challenges]
type: "post"
showTableOfContents: true
---

## Overview

![Beta-taskLoginPage](/images/aks-betataskpage.png)

---

## 🔑 Key Highlights

- **Zero-downtime rolling updates** on AKS deployments  
- **40% faster image builds** via optimized Docker layering  
- **Automated CI/CD** with GitHub Actions (build-and-push & deploy-to-aks)  
- **Cost-efficient AKS** cluster on Standard_B2s nodes  
- **Live observability** with **Prometheus** & **Grafana** dashboards  

---

![ Grafana Dashboard ](/images/aks-prometheus-grafana.png)

*Prometheus-powered Grafana dashboard tracking CPU & memory usage*

---

**BetaTask‑Solutions** is a collaborative pet project between me and one developer friend. While my friend focused on application development (Node/Express backend and Vue/Vite frontend), I owned the infrastructure side. We chose our tools to meet three core needs:

* A **scalable** platform to handle unpredictable load
* A **repeatable** Infrastructure as Code (IaC) process for fast iterations
* **Observability** into both cluster health and application performance

After evaluating several cloud-native options, we settled on:

1. **Terraform** for IaC
2. **Azure Kubernetes Service (AKS)** using the cheapest tier (Standard\_B2s) for node pools
3. **Azure Container Registry (ACR)** for image storage
4. **GitHub Actions** for a two-stage CI/CD pipeline
5. **Prometheus & Grafana** for metrics and dashboards

In this post, I’ll explain *why* each choice made sense and *how* we navigated the biggest challenges along the way.

---

## 🔧 Tools & Technologies

* **Terraform (modular)** – Reusable modules to provision networking, AKS, and ACR
* **Azure Kubernetes Service (AKS)** – Managed control plane, Azure AD integration, and low-cost Standard\_B2s nodes for development/testing
* **Azure Container Registry (ACR)** – Private, in-region Docker registry for faster pull times and reduced egress
* **Docker** – Containerization for backend and frontend applications
* **GitHub Actions** – Two linked workflows: `build-and-push` & `deploy-to-aks`
* **Prometheus & Grafana** – End-to-end monitoring stack for cluster and application metrics

---

## 🧱 Architecture Diagram

![Architecture Diagram](/images/beta-task.png)


## 💻 Project Structure

```text
ToDoList-Solutions/
├── .github/                  # GitHub Actions workflows
│   └── workflows/
│       ├── build-and-push.yml
│       └── deploy-to-aks.yml
├── frontend/                    # Vue 3 frontend
│   ├── src/
│   │   ├── components/         # Vue components
│   │   │   ├── AddTodoModal.vue
│   │   │   ├── CalendarPage.vue
│   │   │   ├── DashboardPage.vue
│   │   │   ├── Notes.vue
│   │   │   ├── NotificationCenter.vue
│   │   │   ├── ReminderModal.vue
│   │   │   ├── TagsManager.vue
│   │   │   └── TodoItem.vue
│   │   ├── composables/        # Vue composables
│   │   │   ├── useAuth.js
│   │   │   └── useNotifications.js
│   │   ├── services/           # API services
│   │   └── firebase.js         # Firebase configuration
├── backend/                     # Node.js backend (optional)
│   ├── routes/                 # API routes
│   │   ├── auth.js
│   │   └── reminders.js
│   ├── middleware/             # Authentication middleware
│   ├── tests/                  # Test files
│   └── server.js               # Entry point
├── Infra/                      # Terraform infrastructure
│   ├── environments/dev/       # Development environment
│   ├   ├── backend.tf                  # Backend configuration - Tfstate file configuration 
│   ├   ├── main.tf                  # Module main reusable file
│   ├   ├── provider.tf                # Reusable Terraform modules
│   ├   ├── variables.tf                 # Variable file
│   ├   ├── secrets.tfvars                 # default variable file
│   └── modules/                # Terraform modules
│   │   ├── resource-group/       # Azure resource group for all the services
│   │   ├── aks/       # Azure Kubernetes terraform configuration file
│   │   ├── container-registry/         # Azure container registry to store the images
├── firestore.rules             # Firestore security rules
├── docker-compose.yml          # Multi-service setup
├── *-deployment.yaml           # Kubernetes deployments
└── *-service.yaml              # Kubernetes services
```

---

## 🚀 Deployment Guide

### 1. Clone the repo

   ```bash
   git clone https://github.com/kingdave4/BetaTask-Solutions.git
   cd BetaTask-Solutions/Infra/environments/dev
   ```

### 2. Create your own terraform.tfvars file
   
   ```bash
   touch terraform.tfvars
   ```
   Open terraform.tfvars and fill in your own values:

   ```tf
   subscription_id     = "Your Subscription ID"
   resource_group_name = "rg-todo-dev"
   acr_name            = "todocrdev123"

   location     = "eastus2"
   cluster_name = "todo-aks-dev"
   vm_size      = "Standard_B2s"
   tags = {
     environment = "dev"
     project     = "ToDoList"
     owner       = "Your Name(s)"
   }
   ```

### 3. Provision Infrastructure

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

> **Pro Tip:** Store Terraform state in Azure Blob Storage with soft-delete enabled to avoid corruption.

### 4. Configure GitHub Secrets

In your repo settings, add:

* `AZURE_CREDENTIALS` (Service Principal JSON)
* `ACR_LOGIN_SERVER`, `ACR_USERNAME`, `ACR_PASSWORD`

### 5. Run CI/CD Workflows

Push to `main` to trigger **build-and-push**:

1. Checkout code
2. Azure login to ACR
3. Build & tag Docker images (`backend:${{ github.sha }}`, `frontend:${{ github.sha }}`)
4. Push to ACR

On success, **deploy-to-aks** runs:

1. Azure CLI login
2. Fetch AKS credentials
3. `kubectl apply` on `/` manifests

---

## 🔍 Key Decisions & Challenges

### 1. Terraform State Locking

* **Why Terraform?**: Modular IaC and team collaboration
* **Challenge**: Concurrent terraform apply runs corrupted state
* **Solution**: Moved state to Azure Blob Storage with built-in state locking and enabled soft-delete to ensure state integrity.

### 2. AKS Tier Selection

* **Why Standard\_B2s?**: Cheapest tier to minimize cost during development/testing
* **Challenge**: Limited CPU/RAM for heavier tests
* **Solution**: Keep a separate autoscaled production cluster (min=2, max=5) with burstable VM sizes

### 3. CI/CD Race Conditions

* **Why two workflows?**: Clear separation between building images and deploying them
* **Challenge**: Early deploy attempts occasionally used images before they finished pushing to ACR
* **Solution**:
  1. Saved the built image tag (IMAGE_TAG=${{ github.sha }}) to the GitHub Actions environment in the build-and-push workflow.
  
  2. Used the workflow_run trigger in deploy-to-aks to guarantee it only runs after a successful build.
  
  3. Referenced the saved IMAGE_TAG environment variable when updating deployments, eliminating arbitrary delays.

---

## 🔁 How It Works

1. Terraform modules spin up Azure networking, ACR, and AKS (Standard\_B2s nodes).
2. GitHub Actions builds Docker images and pushes to ACR.
3. A second workflow deploys the images to AKS using Kubernetes manifests.
4. Prometheus & Grafana monitor the cluster and app, with alerts for latency, restarts, and resource pressure.

---

## 🎯 Lessons Learned

1. **State Locking Is Crucial**: Prevent overlapping applies.
2. **Cost vs. Performance**: Balance low-cost nodes with autoscaling for production.
3. **Pipeline Dependencies**: Decouple but validate upstream steps complete fully.
4. **Metric Hygiene**: Keep cardinality in check for stable monitoring.

---

## 💭 Final Thoughts

Working on BetaTask-Solutions was an invaluable exercise in balancing cost, complexity, and reliability. By collaborating closely with my developer friend, we ensured our infrastructure choices directly supported application requirements. 

The challenges from Terraform state locking to CI/CD race conditions taught me the importance of robust pipelines, clear dependency management, and careful metric hygiene. This project not only deepened my expertise in Azure, Kubernetes, and observability, but also provided a repeatable blueprint for future cloud-native deployments.

Thanks for reading!

[🔗 Click here to access the project →](/projects/beta-task-project/)
