# This file demonstrates using Terraform random provider to generate and store
# a random password as a secret.
terraform {
  required_version = ">= 0.14.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.83"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

# Create a random value for secret
resource "random_string" "secret" {
  length      = 16
  upper       = true
  min_upper   = 2
  lower       = true
  min_lower   = 2
  numeric     = true
  min_numeric = 2
  special     = true
  min_special = 2
  # Since I use this example often with F5 BIG-IP, set the default set of special characters to those listed in
  # https://my.f5.com/manage/s/article/K2873, excluding all forms of quotation, apostrophe and backslash to avoid
  # potential issues when quoting the string.
  override_special = "!$%^&*()~-+=[]{}:./<>|"
}

# Allow module to create the secret without a value
module "secret" {
  source     = "memes/secret-manager/google"
  version    = "2.2.2"
  project_id = var.project_id
  id         = var.id
  secret     = null
  accessors  = var.accessors
}

# Store actual secret as the latest version if it has been provided.
resource "google_secret_manager_secret_version" "secret" {
  secret      = module.secret.id
  secret_data = random_string.secret.result
}
