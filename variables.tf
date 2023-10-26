variable "project_id" {
  type = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "The project_id must be a string of alphanumeric or hyphens, between 6 and 3o characters in length."
  }
  description = <<EOD
The GCP project identifier where the secret will be created.
EOD
}

variable "id" {
  type = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{1,255}$", var.id))
    error_message = "The id must be a string of alphanumeric, hyphen, and underscore characters, and upto 255 characters in length."
  }
  description = <<EOD
The secret identifier to create; this value must be unique within the project.
EOD
}

variable "auto_replication_kms_key_name" {
  type = string
  validation {
    condition     = coalesce(var.auto_replication_kms_key_name, "unspecified") == "unspecified" ? true : can(regex("^projects/[a-z][a-z0-9-]{4,28}[a-z0-9]/locations/global/keyRings/[a-zA-Z0-9_-]{1,63}/cryptoKeys/[a-zA-Z0-9_-]{1,63}$", var.auto_replication_kms_key_name))
    error_message = "The auto_replication_kms_key_name must be null, empty, or a valid global KMS key identifier."
  }
  default     = ""
  description = <<EOD
An optional Cloud KMS key name to use with Google managed replication. If the value is empty (default), then a Google
managed key will be used for encryption of the secret. See `replication` variable for examples.
EOD
}

variable "replication" {
  type = map(object({
    kms_key_name = string
  }))
  validation {
    condition     = var.replication == null ? true : length(var.replication) == 0 || length(distinct([for k, v in var.replication : v == null ? "x" : coalesce(lookup(v, "kms_key_name"), "unspecified") == "unspecified" ? "x" : "y"])) == 1
    error_message = "The replication must contain a Cloud KMS key for all regions, or an empty string/null for all regions."
  }
  default     = {}
  description = <<EOD
An optional map of replication configurations for the secret. If the map is empty
(default), then automatic replication will be used for the secret. If the map is
not empty, replication will be configured for each key (region) and, optionally,
will use the provided Cloud KMS keys.

NOTE: If Cloud KMS keys are used, a Cloud KMS key must be provided for every
region key.

E.g. to use automatic replication policy with Google managed keys(default)
replication = {}

E.g. to use automatic replication policy with specific Cloud KMS key,
auto_replication_kms_key_name = "my-global-key-name"
replication = {}

E.g. to force secrets to be replicated only in us-east1 and us-west1 regions,
with Google managed encryption keys
replication = {
  "us-east1" = null
  "us-west1" = null
}

E.g. to force secrets to be replicated only in us-east1 and us-west1 regions, but
use Cloud KMS keys from each region.
replication = {
  "us-east1" = { kms_key_name = "my-east-key-name" }
  "us-west1" = { kms_key_name = "my-west-key-name" }
}
EOD
}

variable "secret" {
  type        = string
  sensitive   = true
  description = <<EOD
The secret payload to store in Secret Manager; if blank or null a versioned secret
value will NOT be created and must be populated outside of this module. Binary
values should be base64 encoded before use.
EOD
}

variable "accessors" {
  type    = list(string)
  default = []
  validation {
    condition     = var.accessors == null ? true : length(join("", [for acct in var.accessors : can(regex("^(?:group|serviceAccount|user):[^@]+@[^@]*$", acct)) ? "x" : ""])) == length(var.accessors)
    error_message = "Each accessors value must be a valid IAM account identifier; e.g. user:jdoe@company.com, group:admins@company.com, serviceAccount:service@project.iam.gserviceaccount.com."
  }
  description = <<EOD
An optional list of IAM account identifiers that will be granted accessor (read-only)
permission to the secret.
EOD
}

variable "labels" {
  type = map(string)
  validation {
    # GCP resource labels must be lowercase alphanumeric, underscore or hyphen,
    # and the key must be <= 63 characters in length
    condition     = var.labels == null ? true : length(compact([for k, v in var.labels : can(regex("^[a-z][a-z0-9_-]{0,62}$", k)) && can(regex("^[a-z0-9_-]{0,63}$", v)) ? "x" : ""])) == length(keys(var.labels))
    error_message = "Each label key:value pair must match GCP requirements."
  }
  default     = {}
  description = <<EOD
An optional map of label key:value pairs to assign to the secret resources.
Default is an empty map.
EOD
}

variable "annotations" {
  type = map(string)
  validation {
    # GCP resource annotations keys must begin and end with a lowercase alphanumeric character,
    # and period, underscore, or hyphen characters; the key must be <= 63 characters in length.
    # The values have only a size constraint, which is unenforceable here.
    condition     = var.annotations == null ? true : length(compact([for k, v in var.annotations : can(regex("^[a-z0-9][a-z0-9._-]{0,61}[a-z0-9]?$", k)) ? "x" : ""])) == length(keys(var.annotations))
    error_message = "Each label key:value pair must match GCP requirements."
  }
  default     = {}
  description = <<EOD
An optional map of annotation key:value pairs to assign to the secret resources.
Default is an empty map.
EOD
}

variable "topics" {
  type = list(string)
  validation {
    condition     = var.topics == null ? true : length(join("", [for topic in var.topics : can(regex("^projects/[a-z][a-z0-9-]{4,28}[a-z0-9]/topics/[^/]+$", topic)) ? "x" : ""])) == length(var.topics)
    error_message = "Each topics value must be a valid Pub/Sub Topic id."
  }
  default     = []
  description = <<EOD
An optional list of Cloud Pub/Sub topics that will receive control-plane events for the secret.
Default is an empty list.
EOD
}

variable "ttl_secs" {
  type = number
  validation {
    condition     = var.ttl_secs == null ? true : var.ttl_secs >= 60
    error_message = "The ttl_secs variable must be null or a number >= 60."
  }
  default     = null
  description = <<EOD
An optional time-to-live value expressed as a number of seconds; the secret will be automatically deleted after this
duration. If the value is null (default), there will be no time-to-live applied to the secret.

E.g. to automatically delete the secret after 5 minutes, set
ttl_secs = 600
EOD
}
