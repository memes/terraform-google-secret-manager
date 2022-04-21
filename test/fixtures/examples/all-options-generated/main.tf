terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.18"
    }
  }
}

module "test" {
  source                = "./../../../ephemeral/all-options-generated/"
  id                    = format("%s-%s", var.prefix, var.test_name)
  accessors             = var.accessors
  labels                = var.labels
  length                = var.length
  has_lower_chars       = var.has_lower_chars
  has_numeric_chars     = var.has_numeric_chars
  has_special_chars     = var.has_special_chars
  has_upper_chars       = var.has_upper_chars
  min_lower_chars       = var.min_lower_chars
  min_numeric_chars     = var.min_numeric_chars
  min_special_chars     = var.min_special_chars
  min_upper_chars       = var.min_upper_chars
  project_id            = var.project_id
  replication_locations = var.replication_locations
  special_char_set      = var.special_char_set
}
