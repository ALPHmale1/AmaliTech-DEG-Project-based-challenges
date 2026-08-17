# Kora Analytics — Deployment Architecture & Rollback Strategy

## 1. Overview
This document outlines the deployment automation, container packaging, and failover mechanisms implemented for the Kora Analytics application. The objective is to ensure a deterministic, highly available release pipeline that prevents broken code from reaching end-users.

---

## 2. CI/CD Pipeline Architecture
The continuous integration and deployment pipeline is orchestrated entirely through **GitHub Actions** (`.github/workflows/deploy.yml`). It triggers automatically on any push to the `main` branch.

### Stage 1: Continuous Integration (Test & Build)
* **Testing:** The pipeline first installs dependencies and executes unit tests (`npm test`). If tests fail, the pipeline halts immediately, preventing a broken build.
* **Packaging:** Upon passing tests, the application is containerized using Docker.
* **Registry Integration:** The Docker image is tagged with the unique Git commit SHA (for version tracking) and `latest`, then securely pushed to the **GitHub Container Registry (GHCR)**.

### Stage 2: Continuous Delivery (Deployment)
* **Secure Access:** The pipeline authenticates to the production server via SSH using secrets stored securely in GitHub.
* **Image Pull:** The server pulls the exact immutable image matching the Git SHA that just passed CI.

---

## 3. Advanced Zero-Downtime & Automated Rollback
To satisfy high-availability requirements, the pipeline includes an automated health verification and dynamic rollback mechanism directly in the deployment step.

### Execution Workflow:
1. **State Capture:** Before terminating the existing production container, the pipeline dynamically queries and stores the image tag of the currently running (stable) container.
2. **Container Swap:** The old container is stopped and removed, and the new container is launched (mapped to host port `80`).
3. **Health Probe Initialization:** The pipeline explicitly pauses for 15 seconds to allow the Node.js application process to initialize.
4. **Endpoint Verification:** A synthetic `curl` request is executed against the application's `/health` endpoint.
5. **Conditional Rollback:**
   * **If HTTP 200 OK:** The deployment is marked successful, and the pipeline completes.
   * **If Non-200 / Timeout:** The deployment is flagged as a failure. The pipeline immediately terminates the broken container and spins the previously captured stable image back up. 
6. **Alerting:** The GitHub Action intentionally exits with a failure code, alerting the engineering team to the faulty release while the end-users remain seamlessly on the rolled-back version.
