variable "project_id" {
  type        = string
  description = "GCP project identifier."
}

variable "replication_locations" {
  type        = list(string)
  description = "Set of Secret Manager and/or KMS replication locations where resources will be created."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Optional additional labels to apply to resources."
}
