# This file demonstrates applying all options to the module.
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
  replication = var.replication
  secret      = var.secret
  accessors   = var.accessors
  labels      = var.labels
  annotations = var.annotations
  topics      = var.topics
  ttl_secs    = var.ttl_secs
}
