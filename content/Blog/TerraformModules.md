---
title: "Mastering Terraform Modules: My Learning Journey"
date: 2024-10-26
description: "A personal blog post detailing how I learned Terraform with modules using hands-on practice and a thorough Udemy course."
tags: ["Terraform", "DevOps", "Infrastructure as Code", "Modules", "Cloud Engineering"]
---

I've been exploring in-depth into Infrastructure as Code (IaC) over the last few months, and among the most impressive tools I've discovered is **Terraform**. My latest study led to the successful completion of a valuable Udemy course called *DevOps Beginners to Advanced with Projects*, which you can find at this link: [Udemy Certificate](https://www.udemy.com/certificate/UC-31ed7e8b-7892-4bc0-8184-335d9c0dee8c/).

## Why Terraform?

Being new to Cloud Engineering, I was attracted to Terraform from the very outset due to its declarative style of provisioning infrastructure. It has support for various cloud vendors, aligns with CI/CD pipelines, and introduces consistency and version control to infrastructure management.

## Key Things I Learned

The course began with the basics such as Terraform syntax and the workflow (`init`, `plan`, `apply`, `destroy`) but what really accelerated my learning was utilizing Terraform modules.

### What are Terraform Modules?

Consider modules to be reusable blocks of Terraform code. Similar to functions in coding, modules enable you to encapsulate functionality and reapply it in various environments and projects. This facilitates:

- Reducing repetition  
- Organizing code better  
- Simplifying updates across all environments  

### How I Used Modules

I developed a variety of useful projects throughout the course, ranging from deploying resources to AWS. I developed modules for:

- Subnets and VPCs  
- EC2 instances  
- S3 buckets  

Here's a basic breakdown of how I organized a module:

```hcl
# modules/s3/main.tf
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl
}
```

I then employed it in the following manner in my primary setup:

module "my_s3_bucket" {
  source      = "./modules/s3"
  bucket_name = "my-app-logs"
  acl         = "private"
}


## Takeaways

- Modules are a game-changer: They made my configurations cleaner, reusable, and scalable.

- Terraform requires version control: I learned to manage changes to infrastructure through Git.

- State management is important: Managing the .tfstate file responsibly (and remotely via backends such as S3) is crucial.

## What's Next?

I am now using Terraform in more of my DevOps initiatives and integrating it with Azure, as well as experimenting with provisioning in Terraform Cloud.

## Final Thoughts
This journey solidified my belief that mastering tools like Terraform is foundational for any aspiring Cloud or DevOps Engineer. If you're on a similar path, I highly recommend checking out the Udemy course that helped me level up.