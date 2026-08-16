variable "gcp_project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "gcp_region" {
  type        = string
  description = "GCP region"
  default     = "us-central1"
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone"
  default     = "us-central1-a"
}

variable "admin_ip" {
  type        = string
  description = "Restricted administrator IP for SSH"
}

variable "gcs_bucket_name" {
  type        = string
  description = "Globally unique Cloud Storage bucket name"
}
