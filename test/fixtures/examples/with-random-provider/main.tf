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
  source     = "./../../../ephemeral/with-random-provider/"
  id         = format("%s-%s", var.prefix, var.test_name)
  project_id = var.project_id
  accessors  = var.accessors
}
