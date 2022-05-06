# User Managed Replication

This example shows how to specify an explicit set of locations to use for secret
replication.

## Example at a glance

|Item|Managed by Terraform|Description|
|----|--------------------|-----------|
|Access Control||Not managed by example; permissions to read the secret must be specified externally.|
|Replication|&check;|User specified locations will be  used for replication.|
|Secret Value||User specified.|

<!-- spell-checker: disable -->
### Example terraform.tfvars

```properties
# Example TF vars file
project_id = "my-project-id"
id = "my-secret-id"
secret = "T0pS3cretP@ssword!"
replication = {
    "us-east1" = null
    "us-west1" = null
}
```
