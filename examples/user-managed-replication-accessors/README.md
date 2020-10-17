# User Managed Replication

This example shows how to specify an explicit set of locations to use for secret
replication, and a set of IAM accounts that will have read-only access to the
secret value.

## Example at a glance

|Item|Managed by Terraform|Description|
|----|----------|
|Access Control|&check;|User specified accounts will be granted view access to secret.|
|Replication|&check;|User specified regions will be used for replication.|
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
| accessors | An optional list of IAM account identifiers that will be granted accessor (read-only)<br>permission to the secret. | `list(string)` | n/a | yes |
| id | The secret identifier to create; this value must be unique within the project. | `string` | n/a | yes |
| project\_id | The GCP project identifier where the secret will be created. | `string` | n/a | yes |
| replication\_locations | A list of replication locations for the secret. | `list(string)` | `[]` | no |
| secret | The secret payload to store in Secret Manager. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable MD033 MD034 -->
