---
title: "Portfolio Deployment with Hugo, GitHub, Terraform & Azure Static Web Apps"
date: 2025-02-02
description: "Deploying my personal portfolio using Hugo, GitHub, and Terraform on Azure."
tags: ["Hugo", "Terraform", "Azure", "GitHub Actions", "DevOps"]
categories: ["Projects"]
type: "post"
showTableOfContents: true
---

---

## 📌 Overview

This project focuses on deploying a personal portfolio and blog using Hugo as the static site generator, GitHub for version control, Terraform for infrastructure automation, and Azure Static Web Apps for hosting. The objective is to establish a scalable, automated, and cost-effective method to manage the portfolio site.

### Project Archetectur diagrm
![Diagram for the portfolio](/images/myhugoportofolio.png)

### 🛠️ Technologies Used

- **Static Site Generator:** Hugo
- **Infrastructure as Code:** Terraform
- **Cloud Provider:** Azure Static Web Apps
- **Automation:** GitHub Actions
- **Domain Management:** Godaddy

---
## The deployment process follows this flow:


- **Local Development:** Build and preview the Hugo site locally.
- **Version Control:** Push changes to GitHub.
- **Automation:** GitHub Actions triggers deployment.
- **Infrastructure as Code:** Terraform provisions Azure resources.
- **Deployment:** The site is hosted on Azure Static Web Apps.


### Deployment: The site is hosted on Azure Static Web Apps.

🏗️ How to Deploy Your Portfolio

***🔹 Step 1: Setting Up Hugo***

Install Hugo:

If Hugo is not installed on your device then follow the Hugo installation guide for your operating system [here](https://gohugo.io/installation/).

Create a New Site with the following command:

```sh
hugo new site my-portfolio
```

***🔹 Step 2: Initializing GitHub Repository***

Initialize Git Repository:

Navigate to your project directory and run:

```sh
cd my-portfolio
git init
git add .
git commit -m "Initial commit"
```

Create a new repository on GitHub or you can an existing one if you alraedy have it.

To add Remote and Push:

Connect your local repository to GitHub and push the changes:

```sh
git remote add origin https://github.com/<YOUR_USER_NAME>/my-portfolio.git
git push -u origin main
```

***🔹 Step 3: Provisioning Azure Static Web App with Terraform***
Create a provider.tf, main.tf and variable.tf file with the following content:

*** provider.tf ***

```t
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Configure the Azure provider
provider "azurerm" {
  features {
    # This empty features block is REQUIRED
    # (even if you don't configure any special features)
  }
}
```

*** main.tf ***

```t
# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "static-web-app-rg"
  location = var.location
}

# Static Web App
resource "azurerm_static_web_app" "static_site" {
  name                = var.static_site_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_tier            = "Free"
  sku_size            = "Free"
}

#
```


*** Variable.tf ***

```t
variable "location" {
  description = "Azure region for the resources."
  type        = string
  default     = "eastus2"
}

variable "static_site_name" {
  description = "Name for the Azure Static Web App."
  type        = string
  default     = "my-static-web-app"
}
```


### Initialize and Apply Terraform Configuration:

```sh
terraform init
terraform apply
```
This will provision the Azure Static Web App.

---
### 🔹 Step 4: Configuring GitHub Actions for Deployment ***

Set Up GitHub Actions Workflow: Azure Static Web Apps integrates with GitHub Actions to automate deployments.

Create Workflow File: In your repository, create .github/workflows/azure-static-web-apps.yml with the following content:

``` yml
name: Deploy Hugo Site to Azure Static Web App

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    env:
      AZURE_STATIC_WEB_APPS_API_TOKEN: ${{ secrets.AZURE_STATIC_WEB_APPS_API_TOKEN }}
    
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: recursive

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.125.7' # Update to your Hugo version
          extended: true

      - name: Build Hugo Site
        run: hugo --minify

      - name: Deploy to Azure Static Web Apps
        uses: azure/static-web-apps-deploy@v1
        with:
          action: 'upload'
          app_location: "/"
          output_location: "public"
          azure_static_web_apps_api_token: ${{ secrets.AZURE_STATIC_WEB_APPS_API_TOKEN }}
```

*** Set Secrets: ***

In your GitHub repository settings, add the ***AZURE_STATIC_WEB_APPS_API_TOKEN***  secret. 

You can obtain this token from the Azure portal under your Static Web App's settings.

![Deployement Token ](/images/APiToken.png)



***🔹 Step 5: Managing Custom Domain (Optional)***

Configure Custom Domain:

In the Azure portal, navigate to your Static Web App and add your custom domain. 

Follow the instructions to validate and configure DNS settings.

[click here for the instructions](https://learn.microsoft.com/en-us/azure/static-web-apps/custom-domain)


