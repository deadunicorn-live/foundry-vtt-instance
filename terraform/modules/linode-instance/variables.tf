
variable "instance_type" {
  type    = string
  default = "g6-standard-2"
}

variable "image" {
  type    = string
  default = "linode/debian10"
}

variable "region" {
  type = string
}

variable "label" {
  type = string
}

variable "group" {
  type    = string
  default = "vtt"
}

variable "tags" {
  type    = list(string)
  default = ["vtt"]
}

variable "enable_backup" {
  type    = bool
  default = true
}

variable "enable_watchdog" {
  type    = bool
  default = true
}

