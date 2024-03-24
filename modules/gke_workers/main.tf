locals {
  tags = {
    environment  = "${var.name_prefix}-${var.stage}"
    build_number = "${var.build_number}"
  }

}

resource "google_container_node_pool" "gke_nodepool" {
  name               = "${var.name_prefix}-${var.stage}-gke-nodepool"
  location           = var.region
  node_locations     = var.node_zones
  cluster            = var.cluster_name
  initial_node_count = var.initial_node_count

  autoscaling {
    max_node_count = var.max_node_count
    min_node_count = var.min_node_count
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      initial_node_count
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    image_type      = var.image_type
    machine_type    = var.machine_type
    disk_size_gb    = var.disk_size_gb
    disk_type       = var.disk_type
    service_account = var.account_type == "internal" ? null : var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/monitoring"
    ]

    shielded_instance_config {
      enable_secure_boot = true
      enable_integrity_monitoring = true
    }

    metadata = {
      // Explicitly remove GCE legacy metadata API endpoint.
      disable-legacy-endpoints = "true"
    }
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }
}
