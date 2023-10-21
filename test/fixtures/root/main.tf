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
  source                        = "./../../../"
  id                            = format("%s-%s", var.prefix, var.test_name)
  accessors                     = var.accessors
  labels                        = var.labels
  project_id                    = var.project_id
  auto_replication_kms_key_name = var.auto_replication_kms_key_name
  replication                   = var.replication
  secret                        = var.null_secret ? null : var.secret
  annotations                   = var.annotations
  topics                        = var.topics
}
