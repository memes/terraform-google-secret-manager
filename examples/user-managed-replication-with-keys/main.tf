# This file demonstrates applying user-defined replication options with customer
# managed encryption keys from Cloud KMS.
terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.83"
    }
  }
}

module "secret" {
  source      = "memes/secret-manager/google"
  version     = "2.2.2"
  project_id  = var.project_id
  id          = var.id
  secret      = var.secret
  replication = var.replication
}
