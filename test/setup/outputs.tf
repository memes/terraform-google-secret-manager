output "service_account_email" {
  value       = google_service_account.sa.email
  description = <<-EOD
The email identifier of the generated service account.
EOD
}

output "labels" {
  value       = local.labels
  description = <<-EOD
The labels to use where allowed.
EOD
}

output "prefix" {
  value       = random_pet.prefix.id
  description = <<-EOD
The random prefix to use for all resources in this test run.
EOD
}

output "project_id" {
  value       = var.project_id
  description = <<-EOD
The Google Cloud project identifier to use for resources.
EOD
}

output "replication_locations" {
  value       = var.replication_locations
  description = <<-EOD
The Secret Manager and/or KMS replication locations to use for resources.
EOD
}

output "replication_keys" {
  value       = { for k, v in google_kms_crypto_key.key : split("/", v.key_ring)[3] => v.id }
  description = <<-EOD
A map of location:KMS key ids.
EOD
}
