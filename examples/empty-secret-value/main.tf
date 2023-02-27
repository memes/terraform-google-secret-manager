# This file demonstrates creating a secret that does not have an initial value.
# The value will need to be managed outside of this module.
terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.18"
    }
  }
}

module "secret" {
  source     = "memes/secret-manager/google"
  version    = "2.1.1"
  project_id = var.project_id
  id         = var.id
  secret     = null
}
