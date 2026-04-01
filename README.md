# Azure Cloud Engineer Demo

End-to-End Web App Deployment using Terraform & CI/CD on Azure

---

## Overview

This project demonstrates a complete cloud deployment workflow on Microsoft Azure — from infrastructure provisioning to automated application deployment.

I built this project to simulate how real engineering teams deploy applications reliably and consistently using modern DevOps practices.

---

## What This Project Shows

* Infrastructure as Code using Terraform
* Automated CI/CD pipeline using Azure DevOps
* Deployment of a web application to Azure App Service
* Version-controlled and repeatable deployments

---

## Architecture

![Architecture Diagram](./screenshots/architecture.png)

High-level flow:

1. Code is pushed to repository
2. Azure DevOps pipeline is triggered
3. Terraform provisions Azure resources
4. Application is deployed to Azure App Service

---

## Screenshots

### Pipeline Execution

![Pipeline](./screenshots/pipeline.png)

### Terraform Deployment

![Terraform](./screenshots/terraform.png)

### Deployed Web App

![Web App](./screenshots/webapp.png)

---

## 🛠️Tech Stack

**Cloud & DevOps**

* Microsoft Azure (App Service, Resource Groups)
* Azure DevOps (Pipelines)

**Infrastructure as Code**

* Terraform (HCL)

**Other Tools**

* Git & GitHub
* YAML Pipelines
* Azure CLI

---

##  Project Structure

```
.
├── terraform/
│   └── main.tf
├── app/
│   └── index.html
├── azure-pipelines.yml
└── README.md
```

---

## 🚀How It Works (Step-by-Step)

### 1. Infrastructure Provisioning

Terraform is used to define and provision:

* Resource Group
* App Service Plan
* Azure Web App

```
terraform init
terraform plan
terraform apply
```

---

### 2. CI/CD Pipeline

The Azure DevOps pipeline:

* Triggers on code push
* Runs Terraform to provision/update infrastructure
* Deploys the application automatically

---

### 3. Application Deployment

A simple web application is deployed to Azure App Service and becomes publicly accessible.

---

##  Key Learnings

* Learned how to automate cloud infrastructure using Terraform
* Understood how CI/CD pipelines integrate with infrastructure and applications
* Gained experience debugging deployment issues and improving reliability
* Built a reproducible and scalable deployment workflow

---

## What I Would Improve Next

* Add multi-environment setup (Dev / Staging / Prod)
* Integrate monitoring using Application Insights
* Add approval gates in pipeline
* Containerize the application and deploy with Docker

---

## Why This Project Matters

Manual deployments are slow and error-prone.

This project demonstrates how modern cloud engineers use CI/CD automation to:

* Reduce deployment time
* Ensure consistency across environments
* Improve reliability and scalability

---

## 📬 Contact

Feel free to connect with me or reach out if you’d like to discuss this project!
