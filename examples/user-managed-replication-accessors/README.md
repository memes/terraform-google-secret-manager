# User Managed Replication with accessors

This example shows how to specify an explicit set of locations to use for secret
replication, and a set of IAM accounts that will have read-only access to the
secret value.

## Example at a glance

|Item|Managed by Terraform|Description|
|----|--------------------|-----------|
|Access Control|&check;|User specified accounts will be granted view access to secret.|
|Replication|&check;|User specified regions will be used for replication.|
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
accessors = ["serviceAccount:my-service@my-project-id.iam.gserviceaccount.com", "user:jane@doe.com"]
```
