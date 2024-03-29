variable "accessors" {
  type    = list(string)
  default = []
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "annotations" {
  type    = map(string)
  default = {}
}

variable "prefix" {
  type = string
}

variable "project_id" {
  type = string
}

variable "auto_replication_kms_key_name" {
  type    = string
  default = ""
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

variable "topics" {
  type    = list(string)
  default = []
}

variable "ttl_secs" {
  type    = number
  default = null
}
