# Project 3: Monitoring Foundations with Application Insights and Azure Monitor

## Industry Context
Applications need telemetry and operational signals so teams can understand failures, latency, and usage patterns instead of debugging only after users report problems.

## Business Problem
Without telemetry, performance issues and failures are harder to diagnose, and teams have limited visibility into runtime behavior.

## Objective
Add monitoring-ready instrumentation to the Node.js application and provision Azure Application Insights to support observability in Azure.

## Implementation
- Added Application Insights support in `app/server.js`
- Configured the app to initialize telemetry only when one of these settings exists:
  - `APPLICATIONINSIGHTS_CONNECTION_STRING`
  - `APPINSIGHTS_INSTRUMENTATION_KEY`
- Added routes to simulate operational scenarios:
  - `/error` to generate a failure
  - `/slow` to simulate a delayed response and track custom telemetry
  - `/load` to simulate CPU-heavy processing
- Tracked custom telemetry on `/slow`:
  - event: `SlowRouteTriggered`
  - metric: `CustomProcessingTime`
- Provisioned an `azurerm_application_insights` resource through the Terraform module in `infra/modules/application_insights`
- Exposed Application Insights outputs including the name, connection string, and instrumentation key

## Current Status
- Monitoring resources and application instrumentation are present in the codebase
- The App Service module supports `app_settings`, but the Application Insights connection string wiring is currently commented out in `infra/env/dev/main.tf`
- This means the project is monitoring-ready, but full end-to-end telemetry depends on enabling those app settings during deployment

## Architecture
Node.js App -> Application Insights SDK -> Azure Application Insights -> Azure Monitor

## Tools Used
- Application Insights SDK for Node.js
- Azure Application Insights
- Azure Monitor
- Terraform

## Proof (Screenshots)
- [ ] `app/server.js` showing telemetry setup and simulation routes
- [ ] `infra/modules/application_insights/main.tf`
- [ ] Terraform outputs for Application Insights
- [ ] Azure portal Application Insights resource overview
- [ ] Telemetry results after enabling connection string and hitting `/slow` or `/error`

## Key Learnings
- Learned how to add conditional telemetry instrumentation to a Node.js app
- Practiced creating monitoring resources with Terraform
- Understood the difference between provisioning observability resources and fully wiring application telemetry
- Built realistic test routes for validating failure and latency monitoring
