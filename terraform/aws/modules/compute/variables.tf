variable "instance_name" {
  type = string
}

variable "image" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "inbound_from_port" {
  type = list(string)
}

variable "inbound_to_port" {
  type = list(string)
}

variable "inbound_protocol" {
  type = list(string)
}

variable "inbound_cidr" {
  type = list(string)
}

variable "outbound_from_port" {
  type = list(string)
}

variable "outbound_to_port" {
  type = list(string)
}

variable "outbound_protocol" {
  type = list(string)
}

variable "outbound_cidr" {
  type = list(string)
}

variable "zone" {
  type    = string
  default = "asia-south1-c"
}

variable "startup_script" {
  type    = string
  default = ""
}
