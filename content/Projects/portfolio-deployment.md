---
title: "Portfolio Deployment with Hugo & Terraform"
date: 2025-02-02
description: "Deploying my personal portfolio using Hugo, GitHub, and Terraform on Azure."
tags: ["Hugo", "Terraform", "Azure", "GitHub Actions", "DevOps"]
categories: ["Projects"]
---


# 🚀 Portfolio Deployment with Hugo & Terraform  

## 📌 Overview  
This project is about deploying my **personal portfolio and blog** using **Hugo** as the static site generator, **GitHub for version control**, and **Terraform for infrastructure automation**. The goal is to have a **scalable, automated, and cost-effective** way to manage my portfolio site.  

### 🛠️ Technologies Used  
- **Static Site Generator:** Hugo  
- **Infrastructure as Code:** Terraform  
- **Cloud Provider:** Azure (or AWS/GCP if applicable)  
- **Automation:** GitHub Actions  
- **Domain Management:** Cloudflare (or Azure DNS)  

---

## 📊 Architecture  
*(Insert an architecture diagram here – use Draw.io, Excalidraw, or Mermaid.js in Hugo)*  

The deployment follows this flow:  

1️⃣ **Local Development:** Build the Hugo site and preview it locally.  
2️⃣ **Version Control:** Push changes to **GitHub**.  
3️⃣ **Automation:** GitHub Actions triggers deployment.  
4️⃣ **Infrastructure as Code:** Terraform provisions Azure resources.  
5️⃣ **Deployment:** The site is hosted on Azure (e.g., Azure Static Web Apps, Blob Storage, or a VM).  

---

## 🏗️ **How I Deployed My Portfolio**  

### 🔹 Step 1: Setting Up Hugo  
- Installed **Hugo** locally.  
- Created a new site with:  
  ```bash
  hugo new site my-portfolio
