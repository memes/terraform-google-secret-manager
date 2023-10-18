#
# Module under test outputs
#
output "id" {
  value = module.test.id
}

output "secret_id" {
  value = module.test.secret_id
}

output "effective_inputs" {
  value = jsonencode({
    project_id  = var.project_id
    id          = format("%s-%s", var.prefix, var.test_name)
    replication = {}
    secret      = var.secret
    accessors   = []
    labels      = {}
  })
}
