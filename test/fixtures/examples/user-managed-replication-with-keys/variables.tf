variable "prefix" {
  type = string
}

variable "project_id" {
  type = string
}

variable "replication_locations" {
  type = set(string)
}

variable "replication_keys" {
  type = map(string)
}

variable "secret" {
  type = string
}

variable "test_name" {
  type = string
}
