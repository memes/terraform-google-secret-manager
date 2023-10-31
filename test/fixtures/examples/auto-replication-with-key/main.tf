terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.83"
    }
  }
}

module "test" {
  source                        = "./../../../ephemeral/auto-replication-with-key/"
  id                            = format("%s-%s", var.prefix, var.test_name)
  project_id                    = var.project_id
  auto_replication_kms_key_name = var.auto_replication_kms_key_name
  secret                        = var.secret
}
