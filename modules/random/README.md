# Randomly generated secret with Secret Manager for Terraform

> NOTE: This module is for Terraform 0.13 and newer - use 0.12.x releases for Terraform 0.12

This sub-module provides the same variables and capabilities as the base Secret
Manager module, but will generate a random password to use as the secret value.
Additional fields can be used to customise the password generator.

E.g. to create and store a random alphanumeric password of 8 chars that
*excludes* special characters:

```hcl
module "password" {
  source     = "memes/secret-manager/google//modules/random"
  version    = "1.0.3"
  project_id = "my-project-id"
  id         = "my-secret"

  # By default, random secret value will include 16 uppercase,lowercase, numbers,
  # and special characters; let's change that for the legacy app which can only
  # accept 8 alphanumeric chars.
  length            = 8
  has_special_chars = false
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
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret"></a> [secret](#module\_secret) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [random_password.secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accessors"></a> [accessors](#input\_accessors) | An optional list of IAM account identifiers that will be granted accessor (read-only)<br>permission to the secret. | `list(string)` | `[]` | no |
| <a name="input_has_lower_chars"></a> [has\_lower\_chars](#input\_has\_lower\_chars) | Include lowercase alphabet characters in the generated secret. Default is true;<br>set to false to exclude generating a secret containing lowercase characters. | `bool` | `true` | no |
| <a name="input_has_numeric_chars"></a> [has\_numeric\_chars](#input\_has\_numeric\_chars) | Include numeric characters in the generated secret. Default is true;<br>set to false to exclude generating a secret containing numeric characters. | `bool` | `true` | no |
| <a name="input_has_special_chars"></a> [has\_special\_chars](#input\_has\_special\_chars) | Include special characters in the generated secret. Default is true;<br>set to false to exclude generating a secret containing special characters. | `bool` | `true` | no |
| <a name="input_has_upper_chars"></a> [has\_upper\_chars](#input\_has\_upper\_chars) | Include uppercase alphabet characters in the generated secret. Default is true;<br>set to false to exclude generating a secret containing uppercase characters. | `bool` | `true` | no |
| <a name="input_id"></a> [id](#input\_id) | The secret identifier to create; this value must be unique within the project. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | An optional map of label key:value pairs to assign to the secret resources.<br>Default is an empty map. | `map(string)` | `{}` | no |
| <a name="input_length"></a> [length](#input\_length) | The length of the random string to generate for secret value. Default is 16. | `number` | `16` | no |
| <a name="input_min_lower_chars"></a> [min\_lower\_chars](#input\_min\_lower\_chars) | The minimum number of lowercase characters to include in the generated secret.<br>Default is 0, which allows the randomiser logic to exclude lowercase characters<br>if needed to satisfy other `min_` rules. Note that setting to 0 will not<br>guarantee lowercase characters will be excluded - set `has_lower_chars` to false<br>to exclude lowercase characters from generated secret. | `number` | `0` | no |
| <a name="input_min_numeric_chars"></a> [min\_numeric\_chars](#input\_min\_numeric\_chars) | The minimum number of numeric characters to include in the generated secret.<br>Default is 0, which allows the randomiser logic to exclude numeric characters<br>if needed to satisfy other `min_` rules. Note that setting to 0 will not<br>guarantee numeric characters will be excluded - set `has_numeric_chars` to false<br>to exclude numeric characters from generated secret. | `number` | `0` | no |
| <a name="input_min_special_chars"></a> [min\_special\_chars](#input\_min\_special\_chars) | The minimum number of special characters to include in the generated secret.<br>Default is 0, which allows the randomiser logic to exclude special characters<br>if needed to satisfy other `min_` rules. Note that setting to 0 will not<br>guarantee special characters will be excluded - set `has_special_chars` to false<br>to exclude special characters from generated secret. | `number` | `0` | no |
| <a name="input_min_upper_chars"></a> [min\_upper\_chars](#input\_min\_upper\_chars) | The minimum number of uppercase characters to include in the generated secret.<br>Default is 0, which allows the randomiser logic to exclude uppercase characters<br>if needed to satisfy other `min_` rules. Note that setting to 0 will not<br>guarantee uppercase characters will be excluded - set `has_upper_chars` to false<br>to exclude uppercase characters from generated secret. | `number` | `0` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project identifier where the secret will be created. | `string` | n/a | yes |
| <a name="input_replication_keys"></a> [replication\_keys](#input\_replication\_keys) | An optional map of customer managed keys per location. This needs to match the<br>locations specified in `replication_locations`.<br><br>E.g. replication\_keys = { "us-east1": "my-key-name", "us-west1": "another-key-name" } | `map(string)` | `{}` | no |
| <a name="input_replication_locations"></a> [replication\_locations](#input\_replication\_locations) | An optional list of replication locations for the secret. If the value is an<br>empty list (default) then an automatic replication policy will be applied. Use<br>this if you must have replication constrained to specific locations.<br><br>E.g. to use automatic replication policy (default)<br>replication\_locations = []<br><br>E.g. to force secrets to be replicated only in us-east1 and us-west1 regions:<br>replication\_locations = [ "us-east1", "us-west1" ] | `list(string)` | `[]` | no |
| <a name="input_special_char_set"></a> [special\_char\_set](#input\_special\_char\_set) | Override the 'special' characters used by Terraform's random\_string provider to<br>the set provided. Default is the same set as used by Terraform by default. | `string` | `"!@#$%&*()-_=+[]{}<>:?"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The fully-qualified id of the Secret Manager key that contains the secret. |
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | The project-local id Secret Manager key that contains the secret. Should match<br>the input `id`. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-enable MD033 MD034 -->
