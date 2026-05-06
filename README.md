# Azure AKS CI/CD Project

## Architecture Summary

This repository contains a simple Node.js Express application prepared for deployment to Azure Kubernetes Service.

Current deployment architecture:

1. Node.js Express app lives in `app/`.
2. `app/Dockerfile` builds the app into a production Docker image.
3. Azure DevOps builds the image and pushes it to Azure Container Registry.
4. `K8/K8s-deploy.yaml` defines the Kubernetes Deployment and LoadBalancer Service.
5. Azure DevOps connects to AKS, applies the manifest, updates the Deployment image to the current build ID, and verifies rollout status.

Main Azure resources used:

- Azure Container Registry: `myacrpoojademo`
- AKS cluster: configured in the pipeline variables
- Azure DevOps service connection: `New_project1_servConn`

## What Is Already Complete

- Node.js Express application exists in `app/`.
- Dockerfile exists in `app/Dockerfile`.
- Docker ignore file exists in `app/.dockerignore`.
- Kubernetes manifest exists in `K8/K8s-deploy.yaml`.
- Azure DevOps pipeline exists at `pipelines/dev only/azure-pipelines-docker-build.yml`.
- Terraform files exist for earlier infrastructure work, including Resource Group, App Service, Application Insights, and ACR.

## Deployment Flow

1. Developer pushes changes to `main`.
2. Azure DevOps starts the AKS CI/CD pipeline.
3. Pipeline builds the Docker image from `app/Dockerfile`.
4. Pipeline tags the image with `$(Build.BuildId)`.
5. Pipeline pushes the image to ACR.
6. Pipeline connects to AKS with `az aks get-credentials`.
7. Pipeline applies `K8/K8s-deploy.yaml`.
8. Pipeline updates the Deployment image to the new ACR image tag.
9. Pipeline waits for `kubectl rollout status` to confirm the deployment succeeded.
10. The app is exposed through the Kubernetes LoadBalancer service.

## Commands Used

Local Docker build:

```bash
docker build -t ncpl-app:local ./app
```

Run locally with Docker:

```bash
docker run --rm -p 3000:3000 ncpl-app:local
```

Connect to AKS:

```bash
az aks get-credentials --resource-group <aks-resource-group> --name <aks-cluster-name> --overwrite-existing
```

Apply Kubernetes manifest:

```bash
kubectl apply -f K8/K8s-deploy.yaml
```

Update image manually:

```bash
kubectl set image deployment/myapp myapp=myacrpoojademo.azurecr.io/ncpl-app:<build-id>
```

Verify rollout:

```bash
kubectl rollout status deployment/myapp --timeout=180s
kubectl get pods
kubectl get service myapp-svc
```

## Commands To Run After Connecting To AKS

This repository currently stores the Kubernetes manifest in `K8/`. If you rename that folder to `k8s/`, use the same commands with `k8s/`.

Using the current repo path:

```bash
az aks get-credentials --resource-group <rg> --name <aks-name> --overwrite-existing
kubectl apply --dry-run=server -f K8/
kubectl apply -f K8/
kubectl get pods
kubectl get svc
kubectl rollout status deployment/myapp
```

Using the common lowercase folder name:

```bash
az aks get-credentials --resource-group <rg> --name <aks-name> --overwrite-existing
kubectl apply --dry-run=server -f k8s/
kubectl apply -f k8s/
kubectl get pods
kubectl get svc
kubectl rollout status deployment/myapp
```

## Pipeline Variables To Confirm

Before running the Azure DevOps pipeline, update these variables in `pipelines/dev only/azure-pipelines-docker-build.yml`:

- `aksResourceGroup`: resource group containing the AKS cluster
- `aksClusterName`: AKS cluster name
- `acrName`: Azure Container Registry name
- `imageName`: container image repository name
- `azureServiceConnection`: Azure DevOps service connection name

The AKS cluster must have permission to pull images from ACR. The usual Azure command is:

```bash
az aks update --name <aks-cluster-name> --resource-group <aks-resource-group> --attach-acr myacrpoojademo
```

## Screenshots Checklist

Capture these screenshots for the project submission:

- Azure DevOps pipeline run showing Build and Deploy stages succeeded.
- ACR repository showing the `ncpl-app` image with the build ID tag.
- AKS workload screen showing the `myapp` Deployment running.
- AKS services screen showing `myapp-svc` with an external IP.
- Browser showing the app loaded from the LoadBalancer external IP.
- Terminal output for `kubectl get pods`.
- Terminal output for `kubectl rollout status deployment/myapp`.

## Future Improvements

- Add automated tests to `package.json`.
- Add container vulnerability scanning.
- Add separate dev, staging, and production manifests.
- Add Ingress and TLS instead of exposing the app directly with a LoadBalancer.
- Add Horizontal Pod Autoscaler after resource usage is understood.
- Disable ACR admin user and use managed identity/RBAC only.
- Add Terraform for AKS if the AKS cluster is currently created manually.
