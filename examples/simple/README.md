# Automatic Replication

This example shows how to specify a secret that will have replication managed
automatically.

## Example at a glance

|Item|Managed by Terraform|Description|
|----|--------------------|-----------|
|Access Control||Not managed by example; permissions to read the secret must be specified externally.|
|Replication|&check;|Automatically managed by Secret Manager.|
|Secret Value||User specified.|

<!-- spell-checker: disable -->
### Example terraform.tfvars

```properties
# Example TF vars file
project_id = "my-project-id"
id = "my-secret-id"
secret = "T0pS3cretP@ssword!"
```
