# Secret Manager for Terraform 0.14+

![GitHub release](https://img.shields.io/github/v/release/memes/terraform-google-secret-manager?sort=semver)
![Maintenance](https://img.shields.io/maintenance/yes/2023)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

This module provides an opinionated wrapper around creating and managing secret values
in GCP [Secret Manager](https://cloud.google.com/secret-manager) with Terraform
0.14 and newer.

> NOTE: The random sub-module has been removed from v2.x releases; use Terraform's
> random provider or other method to generate a suitable secret password.

<!-- spell-checker: ignore secretmanager cret -->
Given a project identifier, the module will create a new secret, or update an
existing secret version, so that it contains the value provided. An optional list
of IAM user, group, or service account identifiers can be provided and each of
the identifiers will be granted `roles/secretmanager.secretAccessor` on th

```hcl
module "secret" {
  source     = "memes/secret-manager/google"
  version    = "2.1.1"
  project_id = "my-project-id"
  id         = "my-secret"
  secret     = "T0pS3cret!"
  accessors  = ["group:team@example.com"]
}
```

<!-- spell-checker:ignore markdownlint -->
<!-- markdownlint-disable MD033 MD034-->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_secret_manager_secret.secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) | resource |
| [google_secret_manager_secret_iam_member.secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_iam_member) | resource |
| [google_secret_manager_secret_version.secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_id"></a> [id](#input\_id) | The secret identifier to create; this value must be unique within the project. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project identifier where the secret will be created. | `string` | n/a | yes |
| <a name="input_secret"></a> [secret](#input\_secret) | The secret payload to store in Secret Manager; if blank or null a versioned secret<br>value will NOT be created and must be populated outside of this module. Binary<br>values should be base64 encoded before use. | `string` | n/a | yes |
| <a name="input_accessors"></a> [accessors](#input\_accessors) | An optional list of IAM account identifiers that will be granted accessor (read-only)<br>permission to the secret. | `list(string)` | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | An optional map of label key:value pairs to assign to the secret resources.<br>Default is an empty map. | `map(string)` | `{}` | no |
| <a name="input_replication"></a> [replication](#input\_replication) | An optional map of replication configurations for the secret. If the map is empty<br>(default), then automatic replication will be used for the secret. If the map is<br>not empty, replication will be configured for each key (region) and, optionally,<br>will use the provided Cloud KMS keys.<br><br>NOTE: If Cloud KMS keys are used, a Cloud KMS key must be provided for every<br>region key.<br><br>E.g. to use automatic replication policy (default)<br>replication = {}<br><br>E.g. to force secrets to be replicated only in us-east1 and us-west1 regions,<br>with Google managed encryption keys<br>replication = {<br>  "us-east1" = null<br>  "us-west1" = null<br>}<br><br>E.g. to force secrets to be replicated only in us-east1 and us-west1 regions, but<br>use Cloud KMS keys from each region.<br>replication = {<br>  "us-east1" = { kms\_key\_name = "my-east-key-name" }<br>  "us-west1" = { kms\_key\_name = "my-west-key-name" }<br>} | <pre>map(object({<br>    kms_key_name = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The fully-qualified id of the Secret Manager key that contains the secret. |
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | The project-local id Secret Manager key that contains the secret. Should match<br>the input `id`. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable MD033 MD034 -->
