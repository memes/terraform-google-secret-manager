# Automatic Replication with

This example shows how to allow Google to automatically manage secret replication across locations, and use a Cloud KMS
encryption key to use for secret encryption.

## Example at a glance

|Item|Managed by Terraform|Description|
|----|--------------------|-----------|
|Access Control||Not managed by example; permissions to read the secret must be specified externally.|
|Cloud KMS key||Not managed by example; a suitable KMS key for encryption/decryption must be created externally in global location.|
|Replication|&check;|Automatically managed by Secret Manager.|
|Secret Value||User specified.|
|Pub/Sub Notifications||Not managed by example.|
|TTL||Not managed by example.|

<!-- spell-checker: disable -->
### Example terraform.tfvars

```properties
# Example TF vars file
project_id = "my-project-id"
id = "my-secret-id"
secret = "T0pS3cretP@ssword!"
auto_replication_kms_key_name = "projects/my-project-id/locations/global/keyRings/my-global-keyring/cryptoKeys/global-key"
```
