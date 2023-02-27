terraform {
  # NOTE: sensitive function was added in Terraform 0.15
  required_version = ">= 0.15.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.18"
    }
  }
}

module "test" {
  source     = "./../../../"
  id         = format("%s-%s", var.prefix, var.test_name)
  project_id = var.project_id
  secret     = sensitive(var.secret)
}
