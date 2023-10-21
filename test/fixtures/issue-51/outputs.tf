#
# Module under test outputs
#
output "id" {
  value = module.test.id
}

output "secret_id" {
  value = module.test.secret_id
}

output "secret_created" {
  value = true
}

output "effective_inputs" {
  value = jsonencode({
    project_id                    = var.project_id
    id                            = format("%s-%s", var.prefix, var.test_name)
    auto_replication_kms_key_name = ""
    replication                   = {}
    accessors                     = []
    labels                        = {}
    topics                        = []
  })
}
