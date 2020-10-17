# This file demonstrates applying user-defined replication options with Secret Manager

module "secret" {
  #source                            = "git::https://github.com/memes/terraform-google-secret-manager//modules/random?ref=1.0.0"
  source     = "../../modules/random/"
  project_id = var.project_id
  id         = var.id
  secret     = var.secret
}
