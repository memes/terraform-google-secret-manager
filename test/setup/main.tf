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

resource "random_pet" "prefix" {
  length = 1
  keepers = {
    project = var.project_id
  }
}

# KMS resources can never be fully deleted; use a UUID for KMS naming
resource "random_uuid" "key_prefix" {
  keepers = {
    project = var.project_id
  }
}

locals {
  labels = merge(var.labels, {
    purpose = "automated-testing"
    product = "terraform-google-secret-manager"
    driver  = "kitchen-terraform"
  })
}

resource "google_service_account" "sa" {
  project      = var.project_id
  account_id   = format("%s-test-accessor", random_pet.prefix.id)
  display_name = format("terraform-google-secret-manager test service account")
  description  = <<-EOD
A test service account that initially has no roles or permissions assigned. Will
be used as an accessor for tests that expect a user/group/service account.
EOD
}

resource "google_kms_key_ring" "keyring" {
  for_each = setunion(var.replication_locations)
  project  = var.project_id
  name     = format("%s-%s-test", random_uuid.key_prefix.id, each.value)
  location = each.value
}

resource "google_kms_crypto_key" "key" {
  for_each = google_kms_key_ring.keyring
  name     = each.value.name
  key_ring = each.value.id
  purpose  = "ENCRYPT_DECRYPT"
  labels   = local.labels
}

# Note: the identity cannot be destroyed once created
resource "google_project_service_identity" "identity" {
  provider = google-beta
  project  = var.project_id
  service  = "secretmanager.googleapis.com"
}

resource "google_kms_crypto_key_iam_member" "identity" {
  for_each      = google_kms_crypto_key.key
  crypto_key_id = each.value.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = format("serviceAccount:%s", google_project_service_identity.identity.email)
}
