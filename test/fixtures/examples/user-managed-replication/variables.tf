variable "prefix" {
  type = string
}

variable "project_id" {
  type = string
}

variable "replication_locations" {
  type = set(string)
}

variable "secret" {
  type = string
}

variable "test_name" {
  type = string
}
