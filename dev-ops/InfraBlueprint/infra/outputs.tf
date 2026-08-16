output "instance_public_ip" {
  description = "Public IP of the Compute Engine instance"
  value       = google_compute_instance.web.network_interface[0].access_config[0].nat_ip
}

output "database_connection_name" {
  description = "Cloud SQL database instance connection name"
  value       = google_sql_database_instance.postgres.connection_name
}

output "gcs_bucket_name" {
  description = "Cloud Storage static asset bucket name"
  value       = google_storage_bucket.assets.name
}
