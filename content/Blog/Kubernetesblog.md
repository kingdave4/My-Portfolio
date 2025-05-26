---
title: "Getting to Know Kubernetes: My First Experience and Tips"
date: 2024-08-20
description: "A blog post from an individual after taking a course on the basics of Kubernetes on Udemy, with beginner insights and useful takeaways."
tags: ["Kubernetes", "DevOps", "Containers", "Cloud Native", "Cloud Engineering"]
type: post
showTableOfContents: true
---

Continuing along my journey of becoming a DevOps engineer, I eventually made it to a major milestone: **learning Kubernetes**. This too was a part of the same Udemy course *DevOps Beginners to Advanced with Projects* that, while covering many tools, gave a solid introduction to the basics of Kubernetes.

## Why Kubernetes?

Kubernetes (also referred to as K8s) is the de facto standard for container orchestration. It makes it easy to manage applications running in containers at large scale, allowing for automated deployment, scaling, and management across clusters. It's a must-know for any aspiring Cloud or DevOps Engineer.

## My First Kubernetes Experience

The course led me through:

- Establishing a local Kubernetes cluster via Minikube  
- Deploying simple pods and services  
- Familiarizing myself with key Kubernetes objects like Pods, Deployments, and Services  

It was the ideal starting point—hands-on and not overwhelming.

## Tips I Learned for Beginners

Here are some helpful observations and tips from my initial Kubernetes learning experience:

### 1. Begin with Minikube or Kind

Minikube simplifies spinning up a local development cluster. You don't need a cloud account or extensive setup to get started.

```bash
minikube start
```

### 2. Master the Central Resources First
Start by getting comfortable with the foundational building blocks:

- Pod - The smallest deployable unit in Kubernetes
- Deployment - Maintains replica sets and desired state
- Service - Exposes pods internally or externally
  
### 3. Make Frequent Use of kubectl
kubectl is the primary CLI tool for working with Kubernetes. Use it often to explore and interact with your cluster:

```bash
kubectl get pods
kubectl describe deployment <deployment-name>
kubectl logs <pod-name>
```

### 4. YAML is the Key
Everything in Kubernetes is defined through YAML manifests. Get comfortable writing and reading YAML files:

``` yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
```

### 5. Don't Skip the Dashboard
The Kubernetes Dashboard is a useful visual interface. While optional, it’s a great tool for understanding cluster activity—especially when you're just getting started.

## What's Next?
Now that I’ve learned the basics, my next Kubernetes objectives include:

- Running multi-container applications
- Learning Helm for package management
- Working with persistent volumes and secrets
- Deploying Kubernetes clusters on cloud platforms

## Final Thoughts
Even at its most elementary, Kubernetes felt empowering. It connected all the lessons I’d learned about Docker, Jenkins, and Ansible. It’s no wonder Kubernetes has become the backbone of modern cloud-native infrastructure.

If you're starting out, don’t feel intimidated. The Udemy course was a great place to begin, and I’ll be sharing more of my Kubernetes projects soon on my portfolio site!

