variable "accessors" {
  type = list(string)
}

variable "has_lower_chars" {
  type = bool
}

variable "has_numeric_chars" {
  type = bool
}

variable "has_special_chars" {
  type = bool
}

variable "has_upper_chars" {
  type = bool
}

variable "labels" {
  type = map(string)
}

variable "length" {
  type = number
}

variable "min_lower_chars" {
  type = number
}

variable "min_numeric_chars" {
  type = number
}

variable "min_special_chars" {
  type = number
}

variable "min_upper_chars" {
  type = number
}

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

variable "special_char_set" {
  type = string
}

variable "test_name" {
  type = string
}
