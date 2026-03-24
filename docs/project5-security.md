# Project 5: Security Foundations in Azure Deployment and Infrastructure Code

## Industry Context
Cloud security starts with controlling access to deployment workflows, handling secrets carefully, and avoiding unsupported claims about protections that are not yet implemented.

## Business Problem
If infrastructure and deployment workflows are not structured with security in mind, teams risk exposing credentials, over-permissioning access, and losing visibility into sensitive configuration.

## Objective
Implement foundational security practices in the Azure deployment workflow and Terraform codebase while keeping the project ready for future network hardening.

## Implementation
- Used an Azure DevOps service connection (`New_project1_servConn`) instead of hardcoding Azure credentials in pipeline YAML
- Marked sensitive Terraform outputs for ACR credentials and Application Insights secrets as `sensitive = true`
- Separated infrastructure by environment (`dev`, `staging`, `prod`) to reduce the chance of accidental cross-environment changes
- Used Terraform modules to keep resource definitions organized and easier to review
- Enabled App Service application settings support through the module interface instead of embedding secrets directly into application code
- Used Azure Container Registry authentication through pipeline-driven Azure login before image push
- Added a Kubernetes readiness probe in `K8/K8s-deploy.yaml` to improve deployment reliability and reduce the chance of routing traffic to an unready container

## Current Scope
- This repository does not currently implement:
  - Virtual Networks
  - subnets
  - Network Security Groups
  - private endpoints
  - VPN connectivity
- Those controls are valid next steps, but they are not present in the current codebase and should not be claimed as implemented yet

## Architecture
Azure DevOps Service Connection -> Terraform and Deployment Pipelines -> Azure Resources with Sensitive Outputs and Environment Separation

## Tools Used
- Azure DevOps
- Terraform
- Azure App Service
- Azure Container Registry
- Kubernetes

## Proof (Screenshots)
- [ ] Pipeline variables showing use of `New_project1_servConn`
- [ ] Terraform outputs marked as sensitive
- [ ] `infra/env/dev`, `infra/env/staging`, and `infra/env/prod` structure
- [ ] ACR push step using Azure login
- [ ] Kubernetes readiness probe configuration

## Key Learnings
- Learned to separate implemented security controls from planned future controls
- Practiced safer secret handling patterns in Terraform outputs and deployment configuration
- Understood the security value of environment separation and controlled Azure pipeline access
- Built a cleaner foundation for adding networking and access controls later
