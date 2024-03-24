provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = var.account_type != "internal" && var.access_token_file != "" ? file(var.access_token_file) : null
}

module "gke_cluster" {
  source = "../modules/gke_cluster"

  
  name                       = var.gke_name
  stage                      = var.stage
  region                     = var.region
  name_prefix                = var.name_prefix
  subnet_name                = var.subnet_name
  network_name               = var.network_name 
  kubernetes_version         = var.kubernetes_version
  pods_ipv4_cidr_block       = var.pods_ipv4_cidr_block
  master_ipv4_cidr_block     = var.master_ipv4_cidr_block 
  services_ipv4_cidr_block   = var.services_ipv4_cidr_block
  authorized_ipv4_cidr_block = var.authorized_ipv4_cidr_block
  master_authorized_networks_cidr_blocks = var.master_authorized_networks_cidr_blocks
  secondary_ip_range_names   = var.secondary_ip_range_names
}

module "gke_workers" {
  source = "../modules/gke_workers"

  
  stage                      = var.stage
  region                     = var.region
  project                    = var.project_id
  name_prefix                = var.name_prefix
  disk_type                  = var.disk_type
  image_type                 = var.image_type
  node_zones                 = var.cluster_node_zones
  machine_type               = var.machine_type
  disk_size_gb               = var.disk_size_gb
  cluster_name               = split("/", module.gke_cluster.gke_cluster_id)[5]
  min_node_count             = var.min_node_count
  max_node_count             = var.max_node_count
  service_account            = var.account_type == "internal" ? null : var.service_account
  initial_node_count         = var.initial_node_count
}
