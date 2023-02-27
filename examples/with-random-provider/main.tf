# This file demonstrates using Terraform random provider to generate and store
# a random password as a secret.
terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.18"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

# Create a random value for secret
resource "random_string" "secret" {
  length           = 16
  upper            = true
  min_upper        = 2
  lower            = true
  min_lower        = 2
  number           = true
  min_numeric      = 2
  special          = true
  min_special      = 2
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

module "secret" {
  source     = "memes/secret-manager/google"
  version    = "2.1.1"
  project_id = var.project_id
  id         = var.id
  secret     = random_string.secret.result
}
