provider "google" {
  project = "project-pallavi-tarke"
  region  = "asia-south1"
  zone    = "asia-south1-c"
}

variable "instance_name" {
  type    = string
  default = "live-test-instance"
}

variable "image" {
  type    = string
  default = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2004-lts"
}

variable "machine_type" {
  type    = string
  default = "e2-small"
}

variable "network" {
  type    = string
  default = "default"
}

variable "subnetwork" {
  type    = string
  default = "default"
}

variable "zone" {
  type    = string
  default = "asia-south1-c"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "inbound_from_port" {
  type    = list(string)
  default = ["22"]
}

variable "inbound_to_port" {
  type    = list(string)
  default = ["22"]
}

variable "inbound_protocol" {
  type    = list(string)
  default = ["tcp"]
}

variable "inbound_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "outbound_from_port" {
  type    = list(string)
  default = ["0"]
}

variable "outbound_to_port" {
  type    = list(string)
  default = ["65535"]
}

variable "outbound_protocol" {
  type    = list(string)
  default = ["all"]
}

variable "outbound_cidr" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
