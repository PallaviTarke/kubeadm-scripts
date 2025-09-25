resource "google_compute_firewall" "k8s_fw" {
  name    = "k8s-firewall"
  network = var.network

  dynamic "allow" {
    for_each = toset(range(length(var.inbound_from_port)))
    content {
      protocol = lower(var.inbound_protocol[allow.key])
      ports    = ["${var.inbound_from_port[allow.key]}-${var.inbound_to_port[allow.key]}"]
    }
  }

  source_ranges = var.inbound_cidr
}

resource "google_compute_instance" "k8s" {
  count        = var.instance_count
  name         = count.index == 0 ? "controlplane" : "node0${count.index}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = 20
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {} # Gives external IP
  }

  metadata_startup_script = var.startup_script

  tags = ["k8s-node"]
}
