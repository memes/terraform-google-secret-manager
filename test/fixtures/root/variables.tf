variable "accessors" {
  type    = list(string)
  default = []
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "null_secret" {
  type    = bool
  default = false
}

variable "prefix" {
  type = string
}

variable "project_id" {
  type = string
}

variable "replication_locations" {
  type    = set(string)
  default = []
}

variable "replication_keys" {
  type    = map(string)
  default = {}
}

variable "secret" {
  type = string
}

variable "test_name" {
  type = string
}
