---
title: "Learning Jenkins Basics: My Getting Started Tutorial and Advice"
date: 2024-08-05
description: "A personal blog post discussing how I learned the basics of Jenkins via a course taken on Udemy with beginner-friendly advice and takeaways."
tags: ["Jenkins", "DevOps", "CI/CD", "Automation", "Cloud Engineering"]
type: post
showTableOfContents: true
---

I continued my learning journey in DevOps by exploring **Jenkins**, the widely used, open-source automation server. Within the same Udemy course *DevOps Beginners to Advanced with Projects* I gained a solid understanding of Jenkins and how it integrates into the CI/CD process.

## Why Jenkins?

Jenkins is one of the most popular tools for implementing continuous integration and continuous delivery (CI/CD). It enables the automation of building, testing, and deploying your applications something that plays a crucial role in modern DevOps workflows.

## Getting Started with Jenkins

The course walked me through the fundamentals: installing Jenkins, setting it up, and executing a basic pipeline. I installed Jenkins on an Ubuntu VM, created the initial admin user, and installed essential plugins.

## Tips I Learned As A Beginner

Here are a few key takeaways that helped me as someone just getting started with Jenkins:

### 1. Utilize a Pre-Built VM or Docker

To experiment quickly, it's much easier to use a Docker image or a pre-built VM. This saves time and prevents system-level conflicts.

```bash
docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
```

### Don't Skip Plugin Setup
Plugins are what extend Jenkins' capabilities. Start with core ones like:

- Git
- Pipeline
- GitHub Integration
- Credentials Binding

It's worth spending time understanding what each plugin does.

### Use Declarative Pipelines
Writing your Jenkinsfile using declarative syntax makes the code more readable and maintainable.

``` groovy
pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        echo 'Building...'
      }
    }

    stage('Test') {
      steps {
        echo 'Running tests...'
      }
    }

    stage('Deploy') {
      steps {
        echo 'Deploying...'
      }
    }
  }
}

```

### Secure Jenkins Early
Change default credentials right away and limit access to critical features. Use Jenkins' built-in credential manager to securely store sensitive data.

### Integrate with GitHub
Connecting Jenkins to your GitHub repository enables seamless automation. Webhooks allow Jenkins to trigger builds every time new code is pushed.

## What's Next?
Now that I understand the basics, my next steps with Jenkins will involve:

- Creating more sophisticated pipelines
- Using shared libraries
- Automating Docker builds
- Deploying to cloud platforms

## Final Thoughts

Even learning Jenkins at a foundational level gave me a solid understanding of CI/CD concepts. Together with Terraform and Ansible, Jenkins helps complete the toolchain for modern DevOps automation.

If you're beginning your DevOps journey like I am, I highly recommend getting hands-on with Jenkins. The Udemy course was a great introduction, and I'm looking forward to building on this experience.

