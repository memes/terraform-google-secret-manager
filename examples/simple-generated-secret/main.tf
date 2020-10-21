# This file demonstrates applying user-defined replication options with Secret Manager

module "secret" {
  source     = "memes/secret-manager/google//modules/random"
  version    = "0.12.2"
  project_id = var.project_id
  id         = var.id
}
