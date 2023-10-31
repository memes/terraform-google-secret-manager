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
  value = ""
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
    replication                   = {}
    accessors                     = []
    labels                        = {}
    annotations                   = {}
    topics                        = var.topics
    ttl_secs                      = null
  })
}
