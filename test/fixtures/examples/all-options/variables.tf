variable "accessors" {
  type = list(string)
}

variable "labels" {
  type = map(string)
}

variable "prefix" {
  type = string
}

variable "project_id" {
  type = string
}

variable "replication" {
  type = map(object({
    kms_key_name = string
  }))
}

variable "secret" {
  type = string
}

variable "test_name" {
  type = string
}
