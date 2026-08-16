# AmaliTech DEG — DevOps Project-Based Challenges Portfolio

## Repository Overview

This repository houses the professional DevOps engineering challenges completed for the AmaliTech DEG Program. The portfolio demonstrates competence in **Infrastructure as Code (IaC)**, cloud automation, multi-tier network security design, and containerized **Observability & Monitoring**.

---

## Portfolio Directory & Navigation

The repository is structured into isolated professional projects. Detailed architecture, execution workflows, and validation guides for each challenge reside within their respective subdirectories:

### 1. InfraBlueprint (Terraform GCP Infrastructure as Code)
* **Path:** [`dev-ops/InfraBlueprint/`](./dev-ops/InfraBlueprint/)
* **Client / Scenario:** Vela Payments — High-security fintech payment processing infrastructure.
* **Core Technical Scope:**
  * Complete migration of manual cloud assets into a reproducible Terraform specification.
  * Multi-tier network isolation separating public-facing web subnets from private database subnets.
  * Provisioning of GCP Compute Engine (`e2-micro`), Cloud SQL PostgreSQL (`db-f1-micro`), and Google Cloud Storage (GCS) assets.
  * Secure firewall configuration and automated planning evaluation (`terraform plan`).
* **Documentation:** Refer to [`dev-ops/InfraBlueprint/README.md`](./dev-ops/InfraBlueprint/README.md) for full architecture blueprints and deployment instructions.

### 2. WatchTower (Logistics Observability & Monitoring Stack)
* **Path:** [`dev-ops/WatchTower/`](./dev-ops/WatchTower/)
* **Client / Scenario:** Reyla Logistics — Last-mile delivery backend microservices telemetry.
* **Core Technical Scope:**
  * Unified container orchestration using Docker Compose for three core services (`order-service`, `tracking-service`, `notification-service`).
  * Time-series metrics collection and scraping configuration using **Prometheus** (15s scrape interval).
  * Automated executive dashboard provisioning in **Grafana** (zero-touch file provisioning).
  * Proactive alerting rules (`ServiceDown`, `HighErrorRate`, `ServiceNotScraping`) mapped in `prometheus/alerts.yml`.
  * Stream processing and JSON-structured log aggregation.
* **Documentation:** Refer to [`dev-ops/WatchTower/README.md`](./dev-ops/WatchTower/README.md) for complete setup instructions, alerting validation, and operational log commands.

---

## General Execution Guidelines

To inspect, build, or test either project:
1. Navigate into the specific challenge subdirectory (`cd dev-ops/InfraBlueprint` or `cd dev-ops/WatchTower`).
2. Follow the step-by-step instructions outlined in that project's dedicated README.
