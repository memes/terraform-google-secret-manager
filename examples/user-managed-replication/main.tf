# This file demonstrates applying user-defined replication options with Secret Manager

module "secret" {
  source                = "memes/secret-manager/google"
  version               = "1.0.5"
  project_id            = var.project_id
  id                    = var.id
  secret                = var.secret
  replication_locations = var.replication_locations
}
