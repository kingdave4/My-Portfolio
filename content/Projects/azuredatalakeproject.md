---
title: "Azure Data Lake Deployment and Refresh"
date: 2025-05-26T10:00:00Z
description: "Automating NBA Data Ingestion and Analytics with Terraform, Azure Functions, and Synapse"
image: "Datalake_Workflow_Diagram.png"
tags: ["Azure", "Terraform", "Data Engineering", "Serverless", "Python", "Synapse"]
categories: ["Projects"]
draft: false
---

## Overview

This project automates the provisioning of an end-to-end Azure Data Lake solution using Terraform and Python. It schedules a recurring refresh of NBA player data into Azure Data Lake Gen2 and enables querying with Synapse Analytics. The solution uses Azure Functions for scheduled data ingestion, Azure Key Vault for secret management, and Application Insights for observability.

---

## 🔧 Tools & Technologies

- **Terraform**: Automates deployment of all Azure resources.
- **Azure Storage (Data Lake Gen2)**: Stores raw JSONL-formatted data.
- **Azure Synapse Workspace**: Enables querying data with serverless SQL pools.
- **Azure Key Vault**: Secures API keys and sensitive values.
- **Azure Function (Python)**: Periodically fetches NBA data from [Sportsdata.io](https://sportsdata.io/) and uploads it to the lake.
- **Application Insights & Azure Monitor**: Provides diagnostics, metrics, and custom logging for observability.

---

## 🧱 Infrastructure Diagram

![Architecture Diagram](/images/Datalake_Workflow_Diagram.png)

---

## 💻 Project Structure

```bash
AzureDataLake/
├── Terraform/              # Terraform configuration
│   ├── main.tf             # Main infra config
│   ├── variables.tf        # Input variables
│   └── secrets.tfvars      # Sensitive input variables (excluded from repo)
├── myfunctionapp/          # Azure Function code
│   ├── __init__.py         # Main function trigger
│   ├── data_operations.py  # Handles data fetch and blob upload
│   └── requirements.txt    # Python dependencies
```

---

## 🚀 Deployment Steps

### 1. Clone Repository

```bash
git clone https://github.com/kingdave4/AzureDataLake.git
cd AzureDataLake
```

### 2. Configure Secrets

Create Terraform/secrets.tfvars:

```tf
subscription_id    = "<AZURE_SUBSCRIPTION_ID>"
sql_admin_password = "<SQL_ADMIN_PASSWORD>"
apikey             = "<SPORTSDATA_API_KEY>"
nba_endpoint       = "<NBA_API_ENDPOINT>"
sp_object_id       = "<TERRAFORM_SP_OBJECT_ID>"
```

### 3. Provision Azure Resources

```bash
cd Terraform
terraform init
terraform plan -var-file="secrets.tfvars"
terraform apply -var-file="secrets.tfvars" -auto-approve
```

### 4. Deploy Azure Function

```bash
cd ../myfunctionapp
func azure functionapp publish datafunctionapp54
```

---

## 🧠 Azure Function Logic

### Trigger: Every 10 Minutes

Defined in function.json:

``` json
"schedule": "0 */10 * * * *"
```

### Function Code

``` python
from data_operations import fetch_nba_data, upload_to_blob_storage

def main(mytimer: func.TimerRequest):
    data = fetch_nba_data("MyKeyVault", "SportsDataApiKey")
    if data:
        upload_to_blob_storage("MyKeyVault", data)
```

### Data Operations

* Fetches data using HTTP GET with API key header
* Uploads JSONL to nba-datalake/raw-data/nba_player_data.jsonl

---

## 📊 Querying with Synapse

Sample query:

``` sql
SELECT TOP 10 *
FROM OPENROWSET(
  BULK 'https://<storage-account>.dfs.core.windows.net/nba-datalake/raw-data/nba_player_data.jsonl',
  FORMAT = 'CSV',
  FIELDTERMINATOR = '0x0b',
  FIELDQUOTE = '0x0b'
)
WITH (
    line varchar(max)
) AS [result];
```

![View Synapse Query](/images/Datalake_query.png)

Ensure Synapse Firewall is configured to allow your IP.

---

## 📈 Monitoring and Logs

* **Live Stream Logs**:

``` bash
func azure functionapp log stream --name datafunctionapp54
```

* **Azure Monitor Dashboards**: View traces, logs, and function metrics via Application Insights.

---

## 🧹 Cleanup

Tear down everything:

``` bash
cd Terraform
terraform destroy -var-file="secrets.tfvars" -auto-approve
```

---

## 🗺️ Future Improvements

* CI/CD via Azure DevOps Pipelines
* Data Quality Checks and Validation Layer
* Additional sources like team stats and schedules
* Power BI integration for live dashboards

---

## 📁 Repository

[GitHub - kingdave4/AzureDataLake](https://github.com/kingdave4/AzureDataLake)

---

## 📬 Contact

Feel free to reach out via [GitHub](https://github.com/kingdave4) if you have questions or suggestions!

---
