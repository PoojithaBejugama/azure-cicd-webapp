# Project 4: Containerizing the Application with Docker, ACR, and Kubernetes Deployment

## Industry Context
Containers make application packaging consistent across local development, CI pipelines, and cloud deployment targets.

## Business Problem
Traditional deployments can vary by environment, which makes releases harder to reproduce and troubleshoot.

## Objective
Package the Node.js application as a Docker image, push it to Azure Container Registry, and prepare it for Kubernetes deployment.

## Implementation
- Created a Dockerfile in `app/Dockerfile`
- Used the `node:20.11-alpine` base image for a lightweight Node.js runtime
- Structured the image build to:
  - set `/app` as the working directory
  - copy `package*.json` first
  - run `npm install`
  - copy the rest of the application
  - expose port `3000`
  - start the app with `node server.js`
- Created a dedicated Azure DevOps container pipeline in `pipelines/dev only/azure-pipelines-docker-build.yml`
- Configured the pipeline to:
  - log in to Azure Container Registry
  - build the image from the `app/` directory
  - tag the image with both `$(Build.BuildId)` and `latest`
  - push both tags to `myacrpoojademo.azurecr.io`
  - verify the repository after push
- Added a Kubernetes manifest in `K8/K8s-deploy.yaml` that:
  - deploys 2 replicas
  - uses the image `myacrpoojademo.azurecr.io/ncpl-app:latest`
  - exposes port `3000`
  - defines a readiness probe on `/`
  - exposes the app through a `LoadBalancer` service on port `80`

## Architecture
App Source -> Docker Image -> Azure Container Registry -> Kubernetes Deployment -> LoadBalancer Service

## Tools Used
- Docker
- Azure Container Registry (ACR)
- Azure DevOps Pipelines
- Kubernetes

## Proof (Screenshots)
- [ ] `app/Dockerfile`
- [ ] Docker build and push pipeline run
- [ ] ACR repository showing `ncpl-app`
- [ ] `K8/K8s-deploy.yaml`
- [ ] Kubernetes deployment or service output

## Key Learnings
- Learned how to package a Node.js app into a reusable container image
- Practiced tagging and pushing images to Azure Container Registry
- Understood how CI pipelines can automate container publishing
- Connected the container workflow to a Kubernetes deployment manifest
