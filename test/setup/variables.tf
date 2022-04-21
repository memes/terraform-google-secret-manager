variable "project_id" {
  type        = string
  description = "GCP project identifier."
}

variable "replication_locations" {
  type        = set(string)
  description = "Set of Secret Manager and/or KMS replication_locations where resources will be created."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Optional additional labels to apply to resources."
}
