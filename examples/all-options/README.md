# Generated Secret with all options

This example shows how to specify almost* every available option.

> \* `auto_replication_kms_key_name` is left unspecified since the module will create the secret with user specified
> encryption replication as determined by the `replication` variable.

## Example at a glance

|Item|Managed by module|Description|
|----|-----------------|-----------|
|Access Control|&check;|User specified accounts will be granted view access to secret.|
|Cloud KMS key||Not managed by example; a suitable KMS key for encryption/decryption must be created externally in matching locations.|
|Replication|&check;|User specified locations will be  used for replication.|
|Secret Value||User specified.|
|Pub/Sub Notifications|&check;|Notifications sent to Pub/Sub Topic provided.|
|TTL|&check;|Automatically deleted after specified number of seconds.|

<!-- spell-checker: disable -->
### Example terraform.tfvars

```properties
# Example TF vars file
project_id = "my-project-id"
id = "my-secret-id"
secret = "T0pS3cretP@ssword!"
replication = {
    "us-east1" = {
        kms_key_name = "projects/my-project-id/locations/us-east1/keyRings/my-east-keyring/cryptoKeys/east-key"
    }
    "us-west1" = {
        kms_key_name = "projects/my-project-id/locations/us-west1/keyRings/my-east-keyring/cryptoKeys/west-key"
    }
}
accessors = ["serviceAccount:my-service@my-project-id.iam.gserviceaccount.com", "user:jane@doe.com", "group:devops@example.com"]
labels = {
    "stage": "dev",
    "cost_center": "product_dev",
    "owner": "jane_at_example_com"
}
annotations = {
    "stage": "dev",
    "cost_center": "product_dev",
    "owner": "jane_at_example_com"
}
topics = [
    "projects/my-project-id/topics/my-secret-topic"
]
ttl_secs = 86400
```
