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

variable "replication" {
  type = map(object({
    kms_key_name = string
  }))
  default = {}
}

variable "secret" {
  type = string
}

variable "test_name" {
  type = string
}
