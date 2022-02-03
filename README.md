# Secret Manager for Terraform

> NOTE: This module is for Terraform 0.13 and newer - use 0.12.x releases for Terraform 0.12

This module provides an opinionated wrapper around creating and managing secret values
in GCP [Secret Manager](https://cloud.google.com/secret-manager) with Terraform
0.13 and newer.

<!-- spell-checker: ignore secretmanager cret -->
Given a project identifier, the module will create a new secret, or update an
existing secret version, so that it contains the value provided. An optional list
of IAM user, group, or service account identifiers can be provided and each of
the identifiers will be granted `roles/secretmanager.secretAccessor` on th

```hcl
module "secret" {
  source     = "memes/secret-manager/google"
  version    = "1.0.3"
  project_id = "my-project-id"
  id         = "my-secret"
  secret     = "T0pS3cret!"
  accessors  = ["group:team@example.com"]
}
```

The [random](modules/random) sub-module can be used to create a secret with a
generated value.

```hcl
module "secret" {
  source     = "memes/secret-manager/google//modules/random"
  version    = "1.0.3"
  project_id = "my-project-id"
  id         = "my-secret"

  # My application requires a 12 character alphanumeric password that must
  # contain at least one of these special chars: #$%@
  length            = 12
  min_special_chars = 1
  special_char_set  = "#$%@"
}
```

<!-- spell-checker:ignore markdownlint -->
<!-- markdownlint-disable MD033 MD034-->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.44 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.44 |

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
| <a name="input_accessors"></a> [accessors](#input\_accessors) | An optional list of IAM account identifiers that will be granted accessor (read-only)<br>permission to the secret. | `list(string)` | `[]` | no |
| <a name="input_id"></a> [id](#input\_id) | The secret identifier to create; this value must be unique within the project. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | An optional map of label key:value pairs to assign to the secret resources.<br>Default is an empty map. | `map(string)` | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project identifier where the secret will be created. | `string` | n/a | yes |
| <a name="input_replication_keys"></a> [replication\_keys](#input\_replication\_keys) | An optional map of customer managed keys per location. This needs to match the<br>locations specified in `replication_locations`.<br><br>E.g. replication\_keys = { "us-east1": "my-key-name", "us-west1": "another-key-name" } | `map(string)` | `{}` | no |
| <a name="input_replication_locations"></a> [replication\_locations](#input\_replication\_locations) | An optional list of replication locations for the secret. If the value is an<br>empty list (default) then an automatic replication policy will be applied. Use<br>this if you must have replication constrained to specific locations.<br><br>E.g. to use automatic replication policy (default)<br>replication\_locations = []<br><br>E.g. to force secrets to be replicated only in us-east1 and us-west1 regions:<br>replication\_locations = [ "us-east1", "us-west1" ] | `list(string)` | `[]` | no |
| <a name="input_secret"></a> [secret](#input\_secret) | The secret payload to store in Secret Manager. Binary values should be base64<br>encoded before use. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The fully-qualified id of the Secret Manager key that contains the secret. |
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | The project-local id Secret Manager key that contains the secret. Should match<br>the input `id`. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable MD033 MD034 -->
