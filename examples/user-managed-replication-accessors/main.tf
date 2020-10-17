# This file demonstrates applying user-defined replication options, and setting
# access control to the secret value.

module "secret" {
  #source                            = "git::https://github.com/memes/terraform-google-secret-manager?ref=1.0.0"
  source                = "../../"
  project_id            = var.project_id
  id                    = var.id
  secret                = var.secret
  replication_locations = var.replication_locations
  accessors             = var.accessors
}
