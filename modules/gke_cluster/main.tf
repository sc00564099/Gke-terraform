module "label" {
  source       = "../labels"
  name_prefix  = var.name_prefix
  stage        = var.stage
  name         = var.name
  delimiter    = var.delimiter
  attributes   = compact(concat(var.attributes, ["cluster"]))
}
locals {
  tags = {
    environment  = "${var.name_prefix}-${var.stage}"
    build_number = "${var.build_number}"
    it_owner     = "${var.it_owner}"
  }

}
data "google_compute_network" "network" {
  name     = "network -name"
  project = "project-name"
}


data "google_compute_subnetwork" "subnetwork" {
  name    = "subnetwork-name"
  network = data.google_compute_network.network.self_link
  project = "project-name"
  secondary_ip_range {
    range_name    = "test-pods-2"
  }
  secondary_ip_range {
    range_name    = "test-services-2"
  }
}

resource "google_container_cluster" "gke_cluster" {
  name               = module.label.id 
  location           = var.region
  min_master_version = var.kubernetes_version
  description        = "${var.build_number} | ${var.it_owner}"
  resource_labels    = merge(
    {
      name          = "${var.name_prefix}-${var.stage}-gke-nodepool"
      location      = var.region
      type          = "gke_cluster-google_container_cluster-gke_cluster"
    },
    local.tags
  )

  remove_default_node_pool = true
  initial_node_count       = 1
  enable_shielded_nodes    = true
  node_config {
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }

  dynamic "ip_allocation_policy" {
    for_each = var.account_type == "internal" ? [1] : []
    content {
      cluster_secondary_range_name  = data.google_compute_subnetwork.subnetwork.secondary_ip_range[0].range_name
      services_secondary_range_name = data.google_compute_subnetwork.subnetwork.secondary_ip_range[1].range_name
    }
  }

  dynamic "ip_allocation_policy" {
    for_each = var.account_type == "internal" ? [] : [1]
    content {
      cluster_ipv4_cidr_block  = var.pods_ipv4_cidr_block
      services_ipv4_cidr_block = var.services_ipv4_cidr_block
    }
  }

  network    = var.account_type == "internal" ? "projects/project-name/global/networks/network -name" : var.network_name
  subnetwork = var.account_type == "internal" ? "projects/project-name/regions/us-east4/subnetworks/subnetwork-name" : var.subnet_name

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_networks_cidr_blocks
      content {
        cidr_block   = cidr_blocks.value.cidr_block
        display_name = cidr_blocks.value.display_name
      }
    }
  }

  private_cluster_config {
    enable_private_endpoint = false 
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }
  
  release_channel {
    channel = "STABLE"
  }
}
