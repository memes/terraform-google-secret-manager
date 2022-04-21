# User Managed Replication

This example shows how to specify an explicit set of locations to use for secret
replication, and use a Cloud KMS encryption key to

## Example at a glance

|Item|Managed by Terraform|Description|
|----|--------------------|-----------|
|Access Control||Not managed by example; permissions to read the secret must be specified externally.|
|Cloud KMS key||Not managed by example; a suitable KMS key for encryption/decryption must be created externally in matching locations.|
|Replication|&check;|User specified locations will be  used for replication.|
|Secret Value||User specified.|

<!-- spell-checker: disable -->
### Example terraform.tfvars

```properties
# Example TF vars file
project_id = "my-project-id"
id = "my-secret-id"
secret = "T0pS3cretP@ssword!"
replication_locations = ["us-east1", "us-west1"]
replication_keys = {
    "us-east1" = "projects/my-project-id/locations/us-east1/keyRings/my-east-keyring/cryptoKeys/east-key"
    "us-west1" = "projects/my-project-id/locations/us-west1/keyRings/my-east-keyring/cryptoKeys/west-key"
}
```
