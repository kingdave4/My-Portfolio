---
title: "Building My Cloud Portfolio with Hugo, Terraform, and Azure"
date: 2025-05-25
description: "A DevOps-focused walkthrough of deploying a personal portfolio and blog using modern cloud practices."
tags: [cloud, devops, azure, terraform, hugo, github-actions, portfolio]
type: "post"
---

## The Vision

My goal was simple: create a robust, scalable, and automated solution to host my personal portfolio and blog. I wanted a setup that would not only display my work and professional information, but also reflect my proficiency in cloud engineering and DevOps.

By combining **Hugo** for site generation, **Terraform** for infrastructure automation, **Azure Static Web Apps** for hosting, and **GitHub Actions** for CI/CD including deployments for both the static site and an **Azure Function** I achieved a seamless, cloud-native solution that aligns with modern DevOps practices.

---

## Why This Project?

* **Showcasing My Skills:** From Infrastructure as Code (IaC) using Terraform to automated deployments via GitHub Actions, this project reflects my technical abilities and learning journey.
* **A Central Hub:** This site is now my digital resume hosting my blogs, projects, and even a downloadable version of my resume in a dedicated section.
* **Smooth Career Transition:** As I pivot from IT Support to Cloud Engineering, this project has provided essential hands-on experience with cloud platforms, observability, and CI/CD.

---

## The Tech Stack

* **Hugo:** Fast static site generator used to build the blog and portfolio content.
* **Terraform:** To provision all Azure resources in a repeatable and modular fashion.
* **Azure Static Web Apps:** Hosts my Hugo site with free, scalable, and globally distributed hosting.
* **GitHub Actions:** Used to deploy both the static site and an Azure Function API via a single YAML workflow.
* **Azure Function App:** Handles backend logic like contact form submission.
* **Azure Blob Storage:** Stores my resume in a `$web` container as part of the static website configuration.
* **Azure Key Vault + Application Insights:** Provides secure secret storage and application monitoring.

---

## How It Works

1. **Local Development:** I designed and tested the site locally using Hugo.
2. **Version Control with GitHub:** All changes are committed and pushed to the main branch.
3. **GitHub Actions CI/CD:** A unified GitHub Actions workflow handles:

   * Hugo site build
   * Deploy to Azure Static Web Apps
   * Deploy Azure Function App using the same workflow file
4. **Infrastructure Provisioning:**

   * Resource Group
   * Static Web App
   * Blob Storage with `$web` container
   * Azure Function + Service Plan
   * Key Vault for secrets (e.g., SendGrid API key)
   * Application Insights for monitoring
5. **Resume Hosting:** My resume is available as a PDF hosted in Azure Blob Storage’s static website endpoint.

---

## Project Highlights

* ✅ **Modular Terraform Setup:** Easily reusable modules for resource group, static web app, storage, function app, and monitoring.
* ✅ **Unified GitHub Actions Workflow:** Deploys both frontend and backend with minimal manual intervention.
* ✅ **Contact Form Support:** Integrated contact form with Azure Function backend.
* ✅ **Professional and Personal Brand:** The site serves as a live portfolio, blog, and resume distribution channel.

---

## Final Thoughts

This project has been transformational in my career journey. It not only serves as a centralized hub for my work but also validates my ability to implement DevOps and cloud-native solutions in a professional setting.

I’m proud of the outcome and excited to build on this foundation by contributing more content, refining the infrastructure, and adding observability enhancements.

*Stay tuned to my blog for more DevOps, cloud engineering, and automation-focused content. And if you're a recruiter or fellow tech enthusiast [feel free to reach out](https://www.linkedin.com/in/david-mboli-idie-38b974209/).*

Thanks for reading!
