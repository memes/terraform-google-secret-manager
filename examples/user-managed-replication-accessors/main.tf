# This file demonstrates applying user-defined replication options, and setting
# access control to the secret value.

module "secret" {
  source                = "memes/secret-manager/google"
  version               = "0.12.2"
  project_id            = var.project_id
  id                    = var.id
  secret                = var.secret
  replication_locations = var.replication_locations
  accessors             = var.accessors
}
