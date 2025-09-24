resource "google_compute_firewall" "instance_fw" {
  name    = "k8s-node-fw"
  network = var.network

  # Inbound rules
  dynamic "allow" {
    for_each = toset(range(length(var.inbound_from_port)))
    content {
      protocol = lower(var.inbound_protocol[allow.key])
      ports    = [ "${var.inbound_from_port[allow.key]}-${var.inbound_to_port[allow.key]}" ]
    }
  }

  source_ranges = var.inbound_cidr
}

resource "google_compute_instance" "example" {
  count        = var.instance_count
  name         = count.index == 0 ? "controlplane" : "node0${count.index}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {} # External IP
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    hostnamectl set-hostname ${count.index == 0 ? "controlplane" : "node0${count.index}"}
  EOF

  tags = ["k8s-node"]
}
