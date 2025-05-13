---
title: "Weather Dashboard Project"
date: "2025-01-07"
tags: ["AWS", "Python", "boto3", "OpenWeatherMap", "DevOps", "30 Days DevOps Challenge"]
description: "A project post for my Weather Dashboard project, which fetches weather data from the OpenWeatherMap API and saves it to an AWS S3 bucket using Python and boto3."
type: "page"
weight: 5
showTableOfContents: true
---

---
### 🌟 Project Overview

Welcome to my first project of the 30 Days Devops Challenge!.  
I am excited to start this journey of learning cloud technologies and tackling all the hands-on projects together.

## Project Architecture Diagram
![Diagram ](/images/weather_dashboard_diagram.png)

### Weather Dashboard

Uses a python script to fetch weather data from the OpenWeatherMap API for specific cities mentioned in the list and saves the data in an AWS S3 bucket. Let's dive in!

**What i learned from the Project**

- Setting up and managing AWS S3 buckets through python code using boto3.
- Securing API keys and managing environment variables.
- Best practices in Python API integration.
- Managing cloud resources effectively.

### Prerequisites for the project

**Setup AWS local Access:**
- Make sure you have an AWS account with permissions to create and use S3 buckets.
- Go to the IAM service, then go to Users to generate an access key and then click on download.
- Use the access key to log in locally by using `aws configure`.
- If you don't have AWS CLI installed then please do that first. Here is the link to download it:  
  [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

```bash
AWS_ACCESS_KEY_ID=<your_aws_access_key_id> 

AWS_SECRET_ACCESS_KEY=<your_aws_secret_access_key> 

AWS_DEFAULT_REGION=<aws_region>
```

**Environment Variables:**

Sign up for an API key at [OpenWeatherMap](https://openweathermap.org).

Copy your API key and store it in a `.env` file.

Create the `.env` file in the project directory and include the following:

```bash
WEATHER_API_KEY=<your_openweathermap_api_key> 

AWS_BUCKET_NAME=<base_name_for_your_bucket>
```

## Installation

Clone this repository:

```bash
git clone https://github.com/kingdave4/aws-weather-api.git
cd aws-weather-api
```

Dependencies:

- boto3: For interacting with AWS S3.
- requests: For making HTTP requests to the OpenWeatherMap API.
- python-dotenv: For managing environment variables.


Install dependencies:

```bash
pip install boto3 requests python-dotenv
```

Install the required Python packages version:

```bash
pip install -r requirements.txt
```

Run the program:

```bash
python weather_dashboard.py
```
### Results of the program

Python script ouput
![Program output ](/images/weather_rn_dashbord.png)


S3 Bucket Output

![S3 output ](/images/s3bucke_weather_data.png)
