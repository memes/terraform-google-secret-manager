# This module has been tested with Terraform 0.13 only.
#
terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = ">= 4.83"
  }
}

# Create a slot for the secret in Secret Manager
resource "google_secret_manager_secret" "secret" {
  project     = var.project_id
  secret_id   = var.id
  labels      = var.labels
  annotations = var.annotations
  ttl         = var.ttl_secs == null ? null : format("%.9fs", var.ttl_secs)

  replication {
    dynamic "user_managed" {
      for_each = try(length(var.replication), 0) > 0 ? [1] : []
      content {
        dynamic "replicas" {
          for_each = var.replication
          content {
            location = replicas.key
            dynamic "customer_managed_encryption" {
              for_each = toset(compact([replicas.value != null ? lookup(replicas.value, "kms_key_name") : null]))
              content {
                kms_key_name = customer_managed_encryption.value
              }
            }
          }
        }
      }
    }
    dynamic "auto" {
      for_each = try(length(var.replication), 0) > 0 ? [] : [1]
      content {
        dynamic "customer_managed_encryption" {
          for_each = toset(compact([var.auto_replication_kms_key_name]))
          content {
            kms_key_name = customer_managed_encryption.value
          }
        }
      }
    }
  }

  dynamic "topics" {
    for_each = var.topics != null ? toset(var.topics) : []
    content {
      name = topics.value
    }
  }

  lifecycle {
    ignore_changes = [
      # This module will not assign or manage `version_aliases` since it concerns itself with the creation of a secret
      # and the API prevents assignment of aliases until the secret value exists. Users of the module may add aliases
      # after the fact, so make sure this module ignores them.
      version_aliases,
      # Ignore any changes in `rotation` value; this module will NOT set or modify these values since they will cause
      # unintentional drift when used in the real-world. For example, a secret created with rotation_period of 1h and
      # next_rotation_time of now + 61m will show a diff in 2 hours time, should a `terraform plan` or `terraform apply`
      # be executed. This will be unintentional and I argue that the incorrect action would be to reset the secret.
      rotation,
    ]
  }
}

# Store actual secret as the latest version if it has been provided.
resource "google_secret_manager_secret_version" "secret" {
  count       = length(compact([var.secret])) > 0 ? 1 : 0
  secret      = google_secret_manager_secret.secret.id
  secret_data = var.secret
}

# Allow the supplied accounts to read the secret value from Secret Manager
# Note: this module is non-authoritative and will not remove or modify this role
# from accounts that were granted the role outside this module.
resource "google_secret_manager_secret_iam_member" "secret" {
  for_each  = var.accessors != null ? toset(var.accessors) : []
  project   = var.project_id
  secret_id = google_secret_manager_secret.secret.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value
}
