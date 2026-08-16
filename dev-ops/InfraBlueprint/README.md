# InfraBlueprint — Vela Payments Infrastructure as Code (Terraform Enterprise Specification)

## 1. Executive Summary & Business Context

* **Client:** Vela Payments
* **Industry:** Fintech — High-security payment processing for small businesses
* **The Engineering Challenge:** Vela's historical infrastructure was assembled over two years via manual clicks in the cloud console. Documentation was non-existent, and following the departure of the lead engineer, the organization faced a critical single-point-of-failure risk: no one could audit running assets, calculate exact operational costs, or deterministically rebuild the environment from scratch.
* **The Directive:** Establish a fully reproducible, automated Infrastructure as Code (IaC) framework using Terraform. If the entire cloud environment is expunged, an incoming engineer must be able to provision and verify the entire stack cleanly using a single automated command sequence.

---

## 2. Technical Adaptation & Architectural Pivot

While the target specification historically targeted Amazon Web Services (AWS), critical account verification holds on fresh organizational environments introduced compliance and deployment blockers. To satisfy the strict submission deadline without compromising technical depth, the infrastructure was refactored and ported to **Google Cloud Platform (GCP)**. 

GCP provides an exact enterprise-grade 1:1 functional equivalent for every required AWS component:
* **AWS VPC & Subnets** -> **GCP Custom VPC & Subnetworks**
* **AWS EC2 (t2.micro)** -> **GCP Compute Engine (e2-micro, Debian 13)**
* **AWS RDS PostgreSQL (db.t3.micro)** -> **GCP Cloud SQL PostgreSQL (db-f1-micro)**
* **AWS S3 Bucket** -> **Google Cloud Storage (GCS) Bucket**
* **AWS IAM Instance Profile** -> **GCP Service Account with Scoped IAM Bindings**

This pivot ensures absolute structural compliance, secure network segregation, and clean evaluation planning (`terraform plan`) without relying on a live, verified AWS account.

---

## 3. Architecture & Security Topology

The target infrastructure enforces a strict two-tier isolation boundary. Public-facing web components reside in routable subnets, whereas sensitive database resources are entirely isolated within private subnets with public routing disabled.

```text
                                    [ Public Internet ]
                                             │
                                             ▼
                       [ GCP Firewall: vela-allow-web-ssh ]
                     (Inbound HTTP: 80, HTTPS: 443, Restricted SSH: 22)
                                             │
                                             ▼
                        [ Compute Engine Instance (e2-micro) ]
                                     (Public Subnet)
                                     │              │
        ┌────────────────────────────┘              └────────────────────────────┐
        ▼ (Least-Privilege IAM Scopes)                                           ▼
[ Google Cloud Storage (Static Assets) ]                         [ Private Subnet Isolation ]
 (Uniform Access, Versioning Enabled)                           (ipv4_enabled = false, No Public IP)
                                                                                 │
                                                                                 ▼
                                                                  [ Cloud SQL PostgreSQL Database ]
                                                                        (db-f1-micro, Port 5432)
