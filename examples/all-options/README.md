# Generated Secret with all options

This example shows how to specify every option available.

## Example at a glance

|Item|Managed by module|Description|
|----|-----------------|-----------|
|Access Control|&check;|User specified accounts will be granted view access to secret.|
|Cloud KMS key||Not managed by example; a suitable KMS key for encryption/decryption must be created externally in matching locations.|
|Replication|&check;|User specified locations will be  used for replication.|
|Secret Value||User specified.|

<!-- spell-checker: disable -->
### Example terraform.tfvars

```properties
# Example TF vars file
project_id = "my-project-id"
id = "my-secret-id"
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
```
