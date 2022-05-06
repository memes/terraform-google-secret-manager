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
  source      = "./../../../ephemeral/user-managed-replication-with-keys/"
  id          = format("%s-%s", var.prefix, var.test_name)
  project_id  = var.project_id
  replication = var.replication
  secret      = var.secret
}
