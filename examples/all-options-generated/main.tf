# This file demonstrates applying user-defined replication options with Secret Manager

module "secret" {
  source                = "memes/secret-manager/google//modules/random"
  version               = "1.0.1"
  project_id            = var.project_id
  id                    = var.id
  length                = var.length
  has_upper_chars       = var.has_upper_chars
  min_upper_chars       = var.min_upper_chars
  has_lower_chars       = var.has_lower_chars
  min_lower_chars       = var.min_lower_chars
  has_numeric_chars     = var.has_numeric_chars
  min_numeric_chars     = var.min_numeric_chars
  has_special_chars     = var.has_special_chars
  min_special_chars     = var.min_special_chars
  special_char_set      = var.special_char_set
  replication_locations = var.replication_locations
  accessors             = var.accessors
  labels                = var.labels
}
