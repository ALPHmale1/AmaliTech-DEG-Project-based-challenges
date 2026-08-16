# AmaliTech DEG — DevOps Project-Based Challenges Portfolio

This repository contains the completed engineering challenges for the AmaliTech DEG Program, focusing on the **DevOps Engineering Track**. 

The portfolio demonstrates production-ready implementations across three core DevOps domains: Deployment Automation, Infrastructure as Code (IaC), and System Observability.

---

##  Projects Directory

All DevOps challenges are located within the [`dev-ops/`](./dev-ops/) directory.

### 1. [DeployReady](./dev-ops/DeployReady/)
**Client:** Kora Analytics  
**Focus:** Deployment Automation & Application Packaging  

This module focuses on ensuring application code is reliably packaged, tested, and automated for deployment, establishing a deterministic release pipeline for Kora Analytics.
*  **[View DeployReady Architecture & Docs](./dev-ops/DeployReady/README.md)**

### 2. [InfraBlueprint](./dev-ops/InfraBlueprint/)
**Client:** Vela Payments  
**Focus:** Infrastructure as Code (Terraform) & Cloud Security  

A highly secure, reproducible IaC implementation designed to replace manual cloud console configurations with deterministic automation.
* **Network Isolation:** Strict multi-tier network segregation separating public-facing web subnets from private, isolated database subnets.
* **Resource Provisioning:** Automated deployment of Google Cloud Platform (GCP) Compute Engine (`e2-micro`), Cloud SQL PostgreSQL (`db-f1-micro`), and Google Cloud Storage (GCS) assets.
* **Security:** Configured firewall rules enforcing strict ingress constraints.
*  **[View InfraBlueprint Architecture & Docs](./dev-ops/InfraBlueprint/README.md)**

### 3. [WatchTower](./dev-ops/WatchTower/)
**Client:** Reyla Logistics  
**Focus:** Full-Stack Observability & Telemetry  

A complete containerized observability stack built to monitor a multi-service logistics backend (`order-service`, `tracking-service`, `notification-service`).
* **Metrics Ingestion:** **Prometheus** configured for active time-series metrics scraping (15s intervals).
* **Automated Dashboards:** **Grafana** configured with zero-touch file provisioning to instantly load executive dashboards tracking HTTP throughput, 5xx error rates, and target health.
* **Proactive Alerting:** Configured alert rules for `ServiceDown`, `HighErrorRate`, and `ServiceNotScraping`.
* **Structured Logging:** Centralized, JSON-formatted container log streams.
*  **[View WatchTower Architecture & Docs](./dev-ops/WatchTower/README.md)**

---

##  Execution & Verification

To review the specific configurations, architectures, or execution steps for any project:
1. Navigate into the specific project folder under the `dev-ops/` directory.
2. Read the project-specific `README.md` for detailed build, test, and deployment instructions.
