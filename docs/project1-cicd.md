# Project 1: Automated Web Application Deployment with Azure DevOps CI/CD

## Industry Context
Application teams need repeatable deployment workflows so code changes can move from source control to a running environment without manual packaging or ad hoc deployment steps.

## Business Problem
Manual application deployment slows delivery and increases the risk of inconsistent releases between environments.

## Objective
Build an Azure DevOps YAML pipeline that packages a Node.js web application and deploys it to an Azure App Service development environment.

## Implementation
- Created a dedicated Azure DevOps pipeline in `pipelines/dev only/azure-pipelines-app-dev-simple.yml`
- Configured a `Build` stage to:
  - install Node.js 20.x
  - run `npm install` inside the `app/` folder
  - run `npm test` with `continueOnError: true`
  - copy application files and create `app.zip`
  - publish the package as the `app-drop` pipeline artifact
- Configured a `DeployDev` stage to:
  - download the published artifact
  - deploy the ZIP package to Azure App Service using `AzureWebApp@1`
  - target the `webapp-pooja-dev-demo` development web app
- Connected the pipeline to Azure using the `New_project1_servConn` service connection
- Added a deployment summary step that prints the deployed application URL

## Architecture
Git Repo -> Azure DevOps Pipeline -> Build Artifact (`app.zip`) -> Azure App Service (`webapp-pooja-dev-demo`)

## Tools Used
- Azure DevOps
- Azure Pipelines (YAML)
- Node.js
- Azure App Service

## Proof (Screenshots)
- [ ] `pipelines/dev only/azure-pipelines-app-dev-simple.yml`
- [ ] Build stage showing dependency install and package creation
- [ ] Published pipeline artifact (`app-drop`)
- [ ] Deploy stage targeting `webapp-pooja-dev-demo`
- [ ] Application running at the Azure App Service URL

## Key Learnings
- Learned how to structure a two-stage Azure DevOps pipeline for build and deployment
- Understood how pipeline artifacts move between stages
- Practiced App Service ZIP deployment with `AzureWebApp@1`
- Saw how Azure service connections are used inside deployment pipelines
