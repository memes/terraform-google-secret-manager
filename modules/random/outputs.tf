output "id" {
  value       = module.secret.id
  description = <<EOD
The fully-qualified id of the Secret Manager key that contains the secret.
EOD
}

output "secret_id" {
  value       = module.secret.secret_id
  description = <<EOD
The project-local id Secret Manager key that contains the secret. Should match
the input `id`.
EOD
}
