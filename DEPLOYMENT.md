# Deployment Documentation - DeployReady

## 1. Cloud Provider & Service
- **Provider:** Google Cloud Platform (GCP)
- **Service:** Compute Engine (`e2-micro` instance running Debian)
- **Why:** The `e2-micro` instance falls under the GCP Always Free tier, providing a zero-cost, reliable Linux environment with full Docker support.

## 2. Virtual Machine Setup
- Provisioned an `e2-micro` instance in `us-central1-a`.
- **Firewall Rules Configured:**
  - `deployready-allow-http`: Allows inbound TCP traffic on port `80` from `0.0.0.0/0`.
  - `deployready-allow-ssh`: Allows inbound TCP traffic on port `22` restricted to a single administrative IP.

## 3. Docker Installation & Image Management
Docker Engine was installed directly onto the Debian VM. The GitHub Actions CI/CD pipeline automatically builds images, pushes them to GitHub Container Registry (GHCR), and pulls them onto the VM.

## 4. Verification & Operational Commands
- Check if container is running: `docker ps`
- View application logs: `docker logs kora-api`
