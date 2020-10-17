# Automatic Replication

This example shows how to specify a secret that will have replication managed
automatically.

## Example at a glance

|Item|Managed by Terraform|Description|
|----|----------|
|Access Control||Not managed by example; permissions to read the secret must be specified externally.|
|Replication|&check;|Automatically managed by Secret Manager.|
|Secret Value||User specified.|

<!-- spell-checker:ignore markdownlint -->
<!-- markdownlint-disable MD033 MD034-->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| id | The secret identifier to create; this value must be unique within the project. | `string` | n/a | yes |
| project\_id | The GCP project identifier where the secret will be created. | `string` | n/a | yes |
| secret | The secret payload to store in Secret Manager. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable MD033 MD034 -->
