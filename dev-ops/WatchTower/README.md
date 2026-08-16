# WatchTower — Reyla Logistics Observability Stack

## 1. Executive Summary & Business Context

* **Client:** Reyla Logistics
* **Industry:** Last-mile delivery operations & fleet coordination
* **The Problem:** Reyla operates three core backend microservices (`order-service`, `tracking-service`, and `notification-service`). Previously, these services operated in silos with zero centralized monitoring, no performance dashboards, and no automated alerting. System outages, database lockouts, and runtime exceptions were consistently discovered by frustrated end-users rather than internal engineering squads.
* **The Solution:** A fully containerized, production-grade observability stack built on **Prometheus** for metrics ingestion, **Grafana** for pre-provisioned executive dashboarding, **JSON-structured logging** for stream processing, and explicit **Prometheus alerting rules** for proactive incident response.

---

## 2. Microservice Topology & Port Mapping

| Service Name | Port | Functional Responsibility | Metrics Exposure Endpoint |
| :--- | :--- | :--- | :--- |
| **`order-service`** | `3001` | Core order creation, validation, and listing management | `/metrics` & `/health` |
| **`tracking-service`** | `3002` | Real-time vehicle telemetry and delivery status updates | `/metrics` & `/health` |
| **`notification-service`** | `3003` | Event-driven customer alerts and communication dispatch | `/metrics` & `/health` |
| **`Prometheus`** | `9090` | Time-series metrics collection, storage, and rule evaluation | `/targets` & `/alerts` |
| **`Grafana`** | `3000` | Automated visualization UI and dashboard provisioning | `/login` |

---

## 3. Architecture Topology Diagram

```text
                     [ Reyla Logistics Microservices ]
                                     │
         ┌───────────────────────────┼───────────────────────────┐
         ▼                           ▼                           ▼
  [ order-service ]          [ tracking-service ]      [ notification-service ]
   (Port 3001, /metrics)      (Port 3002, /metrics)     (Port 3003, /metrics)
         │                           │                           │
         └───────────────────────────┼───────────────────────────┘
                                     │
                    (Scrapes telemetry every 15 seconds)
                                     ▼
                        [ Prometheus Engine ] ──► [ alerts.yml ]
                                     │             (ServiceDown, HighErrorRate,
                                     │              ServiceNotScraping)
                         (Data Source Proxy)
                                     ▼
                          [ Grafana UI (Port 3000) ]
                       (Auto-Provisioned Dashboards)
