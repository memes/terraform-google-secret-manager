output "id" {
  value       = google_secmoduleret_manager_secret.secret.id
  description = <<EOD
The id of the Secret Manager key that contains the secret.
EOD
}

output "name" {
  value       = module.secret.name
  description = <<EOD
The fully-qualified name of the Secret Manager key that contains the secret.
EOD
}
