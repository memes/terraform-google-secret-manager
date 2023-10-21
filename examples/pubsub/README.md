# Pub/Sub notifications

This example shows how to specify a secret that will send event notification to the specified Pub/Sub Topic. See
[Secret Manager event notifications](https://cloud.google.com/secret-manager/docs/event-notifications#how_event_notifications_work_in)
for more details.

## Example at a glance

|Item|Managed by Terraform|Description|
|----|--------------------|-----------|
|Access Control||Not managed by example; permissions to read the secret must be specified externally.|
|Replication|&check;|Automatically managed by Secret Manager.|
|Secret Value||User specified.|
|Pub/Sub Notifications|&check;|Notifications sent to Pub/Sub Topic provided.|
|TTL||Not managed by example.|

<!-- spell-checker: disable -->
### Example terraform.tfvars

```properties
# Example TF vars file
project_id = "my-project-id"
id = "my-secret-id"
secret = "T0pS3cretP@ssword!"
topics = [
    'projects/my-project-id/topics/my-secret-notifications'
]
```
