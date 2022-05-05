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

variable "replication_locations" {
  type        = list(string)
  default     = []
  description = <<EOD
An optional list of replication locations for the secret. If the value is an
empty list (default) then an automatic replication policy will be applied. Use
this if you must have replication constrained to specific locations.

E.g. to use automatic replication policy (default)
replication_locations = []

E.g. to force secrets to be replicated only in us-east1 and us-west1 regions:
replication_locations = [ "us-east1", "us-west1" ]
EOD
}

variable "replication_keys" {
  type        = map(string)
  default     = {}
  description = <<EOD
An optional map of customer managed keys per location. This needs to match the
locations specified in `replication_locations`.

E.g. replication_keys = { "us-east1": "my-key-name", "us-west1": "another-key-name" }
EOD
  # We cannot use the following validation because we cannot reference other variables
  # validation {
  #   condition     = can([for k in var.replication_keys : contains(var.replication_locations, k)])
  #   error_message = "Each location in replication_keys must be defined in replication_locations"
  # }
}

variable "secret" {
  type        = string
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
    condition     = length(join("", [for acct in var.accessors : can(regex("^(?:group|serviceAccount|user):[^@]+@[^@]*$", acct)) ? "x" : ""])) == length(var.accessors)
    error_message = "Each accessors value must be a valid IAM account identifier; e.g. user:jdoe@company.com, group:admins@company.com, serviceAccount:service@project.iam.gserviceaccount.com."
  }
  description = <<EOD
An optional list of IAM account identifiers that will be granted accessor (read-only)
permission to the secret.
EOD
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = <<EOD
An optional map of label key:value pairs to assign to the secret resources.
Default is an empty map.
EOD
}
