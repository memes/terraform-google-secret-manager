# Accessors

This example shows how to specify a secret with a list of accounts that will have
read-only access to the secret value. Secret replication is managed automatically.

## Example at a glance

|Item|Managed by module|Description|
|----|-----------------|-----------|
|Access Control|&check;|User specified accounts will be granted view access to secret.|
|Replication|&check;|Automatically managed by Secret Manager.|
|Secret Value||User specified.|
|Pub/Sub Notifications||Not managed by example.|
|TTL||Not managed by example.|

### Example terraform.tfvars

<!-- spell-checker: disable -->
```properties
# Example TF vars file
project_id = "my-project-id"
id = "my-secret-id"
secret = "T0pS3cretP@ssword!"
accessors = ["serviceAccount:my-service@my-project-id.iam.gserviceaccount.com", "user:jane@doe.com"]
```
<!-- spell-checker: enable -->
