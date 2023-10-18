#
# Module under test outputs
#
output "id" {
  value = module.test.id
}

output "secret_id" {
  value = module.test.secret_id
}

# The effective inputs to root module, with defaults where no value provided by test case
output "effective_inputs_json" {
  value = jsonencode({
    project_id  = var.project_id
    id          = format("%s-%s", var.prefix, var.test_name)
    replication = var.replication
    secret      = var.secret
    accessors   = []
    labels      = {}
  })
}
