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
│   └── modules/                # Terraform modules
├── firestore.rules             # Firestore security rules
├── docker-compose.yml          # Multi-service setup
├── *-deployment.yaml           # Kubernetes deployments
└── *-service.yaml              # Kubernetes services
```

---

## 🚀 Deployment Guide

### 1. Provision Infrastructure

```bash
cd terraform
terraform init
terraform plan -var-file="secrets.tfvars"
terraform apply -var-file="secrets.tfvars" -auto-approve
```

> **Pro Tip:** Store Terraform state in Azure Blob Storage with soft-delete enabled to avoid corruption.

### 2. Configure GitHub Secrets

In your repo settings, add:

* `AZURE_CREDENTIALS` (Service Principal JSON)
* `ACR_LOGIN_SERVER`, `ACR_USERNAME`, `ACR_PASSWORD`

### 3. Run CI/CD Workflows

Push to `main` to trigger **build-and-push**:

1. Checkout code
2. Azure login to ACR
3. Build & tag Docker images (`backend:${{ github.sha }}`, `frontend:${{ github.sha }}`)
4. Push to ACR

On success, **deploy-to-aks** runs:

1. Azure CLI login
2. Fetch AKS credentials
3. `kubectl apply` on `k8s/` manifests

---

## 🔍 Key Decisions & Challenges

### 1. Terraform State Locking

* **Why Terraform?**: Modular IaC and team collaboration
* **Challenge**: Concurrent applies corrupted state
* **Solution**: Azure Blob backend with state locking + manual approval gate

### 2. AKS Tier Selection

* **Why Standard\_B2s?**: Cheapest tier to minimize cost during development/testing
* **Challenge**: Limited CPU/RAM for heavier tests
* **Solution**: Keep a separate autoscaled prod cluster (min=2, max=5) with burstable VM sizes

### 3. CI/CD Race Conditions

* **Why two workflows?**: Clear separation of build and deploy steps
* **Challenge**: Deploy ran before ACR indexing completed, leading to missing images
* **Solution**: Use `workflow_run` trigger and insert a `sleep 10` before deploy

### 4. Prometheus Cardinality Issues

* **Why Prometheus & Grafana?**: Custom metrics (p95, OOM, node pressure)
* **Challenge**: High cardinality causing “too many series” errors
* **Solution**: Prune labels in scrape configs and limit metric retention

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

[🔗 Click here to access the project →](/projects/portfolio-deployment/)
