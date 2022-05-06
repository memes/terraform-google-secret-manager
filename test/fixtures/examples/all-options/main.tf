terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.18"
    }
  }
}

module "test" {
  source      = "./../../../ephemeral/all-options/"
  id          = format("%s-%s", var.prefix, var.test_name)
  accessors   = var.accessors
  labels      = var.labels
  project_id  = var.project_id
  replication = var.replication
  secret      = var.secret
}
