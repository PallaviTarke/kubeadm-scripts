provider "google" {
  project = "project-pallavi-tarke"   # Replace with your GCP Project ID
  region  = "asia-south1"
  zone    = "asia-south1-c"
}

module "gce_instance" {
  source = "../modules/compute"

  instance_name   = "k8s-node"
  image           = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2004-lts"
  machine_type    = "e2-medium"
  network         = "default"
  subnetwork      = "default"
  instance_count  = 3

  inbound_from_port  = ["0", "6443", "22", "30000", "0"]
  inbound_to_port    = ["65000", "6443", "22", "32768", "65000"]
  inbound_protocol   = ["tcp", "tcp", "tcp", "tcp", "tcp"]
  inbound_cidr       = ["10.128.0.0/20", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "10.244.0.0/16"]

  outbound_from_port = ["0"]
  outbound_to_port   = ["65535"]
  outbound_protocol  = ["all"]
  outbound_cidr      = ["0.0.0.0/0"]
}
