# This module has been tested with Terraform 0.13 only.
#
terraform {
  required_version = ">= 0.13"
  required_providers {
    google = "~> 3.44"
  }
}

# Create a slot for the secret in Secret Manager
resource "google_secret_manager_secret" "secret" {
  project   = var.project_id
  secret_id = var.id
  labels    = var.labels
  replication {
    dynamic "user_managed" {
      for_each = length(var.replication_locations) > 0 ? [1] : []
      content {
        dynamic "replicas" {
          for_each = var.replication_locations
          content {
            location = replicas.value
          }
        }
      }
    }
    automatic = length(var.replication_locations) > 0 ? null : true
  }
}

# Store actual secret as the latest version.
resource "google_secret_manager_secret_version" "secret" {
  secret      = google_secret_manager_secret.secret.id
  secret_data = var.secret
}

# Allow the supplied accounts to read the secret value from Secret Manager
# Note: this module is non-authoritative and will not remove or modify this role
# from accounts that were granted the role outside this module.
resource "google_secret_manager_secret_iam_member" "secret" {
  for_each  = toset(var.accessors)
  project   = var.project_id
  secret_id = google_secret_manager_secret.secret.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value
}
