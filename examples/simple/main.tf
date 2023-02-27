# This file demonstrates a minimal creation of a Secret Manager secret.
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
  secret     = var.secret
}
