terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

resource "google_compute_network" "vpc" {
  name                    = "vela-gcp-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  name          = "vela-public-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "private" {
  name          = "vela-private-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "web_firewall" {
  name    = "vela-allow-web-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }
  source_ranges = [var.admin_ip, "0.0.0.0/0"]
  target_tags   = ["web-server"]
}

resource "google_storage_bucket" "assets" {
  name                        = var.gcs_bucket_name
  location                    = var.gcp_region
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  versioning {
    enabled = true
  }
  force_destroy = true
}

resource "google_service_account" "sa" {
  account_id   = "vela-compute-sa"
  display_name = "Service Account for Web Instance Access"
}

resource "google_storage_bucket_iam_member" "sa_storage" {
  bucket = google_storage_bucket.assets.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_compute_instance" "web" {
  name         = "vela-web-instance"
  machine_type = "e2-micro"
  zone         = var.gcp_zone
  tags         = ["web-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-13"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.public.id
    access_config {}
  }

  service_account {
    email  = google_service_account.sa.email
    scopes = ["https://www.googleapis.com/auth/devstorage.read_write"]
  }
}

resource "google_sql_database_instance" "postgres" {
  name             = "vela-postgres-db"
  database_version = "POSTGRES_15"
  region           = var.gcp_region

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id
    }
  }
  deletion_protection = false
}
