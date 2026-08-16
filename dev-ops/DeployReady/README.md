# Kora Analytics — Infrastructure & Automated Delivery Pipeline

## 1. Executive Overview
This repository contains the containerized application architecture and automated Continuous Integration/Continuous Deployment (CI/CD) pipeline for **Kora Analytics**. 

Previously, deployments relied on manual SSH interventions, lacking testing gates and exposing the infrastructure to operational risks. This project modernizes the delivery lifecycle by implementing strict containerization, automated testing, and secure, zero-touch deployments to Google Cloud Platform (GCP).

---

## 2. Architecture & Pipeline Workflow

The deployment relies on a robust, four-stage GitHub Actions pipeline triggered on every push to the `main` branch.

```text
[Developer Push] 
       │
       ▼
1. [Test Stage]  ──► `npm install` & `npm test` validation. (Fails pipeline if broken)
       │
       ▼
2. [Build Stage] ──► Compiles non-root Docker image tagged with Git SHA.
       │
       ▼
3. [Push Stage]  ──► Pushes image securely to GitHub Container Registry (GHCR).
       │
       ▼
4. [Deploy Stage]──► Secure SSH into GCP VM, pulls new GHCR image, and restarts container.
