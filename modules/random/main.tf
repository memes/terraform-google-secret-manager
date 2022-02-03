# This module has been tested with Terraform 0.13 only.
#
terraform {
  required_version = ">= 0.13"
  required_providers {
    google = ">= 3.44"
  }
}

# Create a random value for secret
resource "random_password" "secret" {
  length           = var.length
  upper            = var.has_upper_chars
  min_upper        = var.min_upper_chars
  lower            = var.has_lower_chars
  min_lower        = var.min_lower_chars
  number           = var.has_numeric_chars
  min_numeric      = var.min_numeric_chars
  special          = var.has_special_chars
  min_special      = var.min_special_chars
  override_special = var.special_char_set
}

module "secret" {
  source                = "../../"
  project_id            = var.project_id
  id                    = var.id
  replication_locations = var.replication_locations
  replication_keys      = var.replication_keys
  accessors             = var.accessors
  labels                = var.labels
  secret                = random_password.secret.result
}
