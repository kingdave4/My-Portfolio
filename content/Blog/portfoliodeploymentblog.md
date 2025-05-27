---
title: "Deploying my Portfolio built with Hugo to Azure web static app"
date: "2025-05-18"
tags: ["Hugo", "Terraform", "Azure", "GitHub Actions", "DevOps", "Portfolio", "Azure Function", "SendGrid"]
description: "I transitioned from IT Support to Cloud Engineering by deploying my portfolio using Hugo, GitHub, Terraform, and Azure Static Web Apps."
type: post
showTableOfContents: true
weight: 40
---

# 🌟 Deploying My Portfolio

When I decided to transition from IT Support to Cloud Engineering, I knew I needed a project that could truly showcase my evolving skill set. That's when I embarked on this project—to build and deploy my personal portfolio and blog using modern DevOps practices. With this portfolio, I can now host all my projects, blogs, and professional information in one place, and I’m excited to share the process with you.

### Project Archetectur diagrm
![Diagram for the portfolio](/images/myhugoportofolio.png)

## The Vision

My goal was simple: create a robust, scalable, and automated solution to host my portfolio. I wanted a setup that would not only display my work but also demonstrate my ability to work with cutting-edge cloud technologies. By combining Hugo as my static site generator, GitHub for version control, Terraform for infrastructure automation, and Azure Static Web Apps for hosting, I was able to achieve a seamless and efficient deployment process.

## Why This Project?

- **Showcasing My Skills:** This project allowed me to put into practice the tools and techniques I've learned. From writing Infrastructure as Code (IaC) with Terraform to automating deployments via GitHub Actions, every step of the project was a learning opportunity.
- **Central Hub for My Work:** With this portfolio, I can now host all my projects and blogs in one unified space. It’s my digital resume that demonstrates my technical expertise and passion for cloud technologies.
- **Seamless Transition:** Moving from IT Support to Cloud Engineering is a big leap. This project helped bridge that gap by giving me hands-on experience with cloud services, automation, and modern deployment practices.

## The Technology Stack

To bring this project to life, I used:

- **Hugo:** A fast and flexible static site generator to build the portfolio.
- **Terraform:** To automate the provisioning of Azure resources.
- **Azure Static Web Apps:** For hosting my portfolio, ensuring it is scalable and cost-effective.
- **GitHub Actions:** Automating the deployment process to keep my site up-to-date with every commit.

## The Process

1. **Local Development:** I started by developing the site locally using Hugo. This allowed me to fine-tune the design and content before pushing it live.
2. **Version Control:** After building the site, I pushed the code to GitHub, ensuring that every change was tracked and managed.
3. **Automation with GitHub Actions:** I set up a GitHub Actions workflow that triggers on every commit, automatically deploying the latest version of my site.
4. **Infrastructure Provisioning:** Using Terraform, I provisioned the necessary Azure resources, making the deployment process entirely reproducible and automated.
5. **Deployment:** Finally, my site was hosted on Azure Static Web Apps, making it publicly accessible and scalable as my audience grows.

## Final Thoughts

This project has been a game changer in my transition to Cloud Engineering. Not only does it serve as a portfolio of my work, but it also reflects my commitment to continuous learning and improvement. By integrating modern DevOps practices and leveraging cloud technologies, I’ve built a platform that not only looks great but also performs reliably.

I’m excited to continue this journey, take on more challenges, and share my progress along the way. Stay tuned for more updates and projects as I explore the dynamic world of cloud engineering!

[🔗 Click here to see the Project →](/projects/portfolio-deployment/)
---



Feel free to reach out if you have any questions about my setup or if you're interested in collaborating on similar projects.
