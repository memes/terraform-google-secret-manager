#
# Module under test outputs
#
output "id" {
  value = module.test.id
}

output "secret_id" {
  value = module.test.secret_id
}

output "expiration_timestamp" {
  value = module.test.expiration_timestamp
}

output "secret_created" {
  value = true
}

# The effective inputs to root module, with defaults where no value provided by test case
output "effective_inputs_json" {
  value = jsonencode({
    project_id                    = var.project_id
    id                            = format("%s-%s", var.prefix, var.test_name)
    auto_replication_kms_key_name = ""
    replication                   = var.replication
    accessors                     = var.accessors
    labels                        = var.labels
    annotations                   = var.annotations
    topics                        = var.topics
    ttl_secs                      = var.ttl_secs
  })
}
