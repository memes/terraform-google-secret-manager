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

variable "length" {
  type    = number
  default = 16
  validation {
    condition     = floor(var.length) == var.length && var.length >= 1
    error_message = "length must be an integer greater than zero."
  }
  description = <<EOD
The length of the random string to generate for secret value. Default is 16.
EOD
}

variable "has_upper_chars" {
  type        = bool
  default     = true
  description = <<EOD
Include uppercase alphabet characters in the generated secret. Default is true;
set to false to exclude generating a secret containg uppercase characters.
EOD
}

variable "min_upper_chars" {
  type    = number
  default = 0
  validation {
    condition     = floor(var.min_upper_chars) == var.min_upper_chars && var.min_upper_chars >= 0
    error_message = "min_upper_chars must be an integer >= 0."
  }
  description = <<EOD
The minimum number of uppercase characters to include in the generated secret.
Default is 0, which allows the randomiser logic to exclude uppercase characters
if needed to satisfy other `min_` rules. Note that setting to 0 will not
guarantee uppercase characters will be excluded - set `has_upper_chars` to false
to exclude uppercase characters from generated secret.
EOD
}

variable "has_lower_chars" {
  type        = bool
  default     = true
  description = <<EOD
Include lowercase alphabet characters in the generated secret. Default is true;
set to false to exclude generating a secret containg lowercase characters.
EOD
}

variable "min_lower_chars" {
  type    = number
  default = 0
  validation {
    condition     = floor(var.min_lower_chars) == var.min_lower_chars && var.min_lower_chars >= 0
    error_message = "min_lower_chars must be an integer >= 0."
  }
  description = <<EOD
The minimum number of lowercase characters to include in the generated secret.
Default is 0, which allows the randomiser logic to exclude lowercase characters
if needed to satisfy other `min_` rules. Note that setting to 0 will not
guarantee lowercase characters will be excluded - set `has_lower_chars` to false
to exclude lowercase characters from generated secret.
EOD
}

variable "has_numeric_chars" {
  type        = bool
  default     = true
  description = <<EOD
Include numeric characters in the generated secret. Default is true;
set to false to exclude generating a secret containg numeric characters.
EOD
}

variable "min_numeric_chars" {
  type    = number
  default = 0
  validation {
    condition     = floor(var.min_numeric_chars) == var.min_numeric_chars && var.min_numeric_chars >= 0
    error_message = "min_numeric_chars must be an integer >= 0."
  }
  description = <<EOD
The minimum number of numeric characters to include in the generated secret.
Default is 0, which allows the randomiser logic to exclude numeric characters
if needed to satisfy other `min_` rules. Note that setting to 0 will not
guarantee numeric characters will be excluded - set `has_numeric_chars` to false
to exclude numeric characters from generated secret.
EOD
}

variable "has_special_chars" {
  type        = bool
  default     = true
  description = <<EOD
Include special characters in the generated secret. Default is true;
set to false to exclude generating a secret containg special characters.
EOD
}

variable "min_special_chars" {
  type    = number
  default = 0
  validation {
    condition     = floor(var.min_special_chars) == var.min_special_chars && var.min_special_chars >= 0
    error_message = "min_special_chars must be an integer >= 0."
  }
  description = <<EOD
The minimum number of special characters to include in the generated secret.
Default is 0, which allows the randomiser logic to exclude special characters
if needed to satisfy other `min_` rules. Note that setting to 0 will not
guarantee special characters will be excluded - set `has_special_chars` to false
to exclude special characters from generated secret.
EOD
}

variable "special_char_set" {
  type        = string
  default     = "!@#$%&*()-_=+[]{}<>:?"
  description = <<EOD
Override the 'special' characters used by Terraform's random_string provider to
the set provided. Default is the same set as used by Terraform by default.
EOD
}
