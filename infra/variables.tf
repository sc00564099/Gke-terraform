# Variables for GOOGLE infrastructure module

#--------------------------------------------------------------------#
# Required variables
#--------------------------------------------------------------------#

variable "name_prefix" {
  type        = string
  description = "Namespace, which could be your username, tenant name or project name"
  default     = "pref"
}

variable "stage" {
  type        = string
  description = "Stage added to names of all resources"
  default     = "test"
}

variable "project_id" {
  type        = string
  default     = "nonprod-plat-test"
  description = "The ID of the project to create resources in"
}

variable "service_account" {
  type        = string
  default     = ""
  description = "The GCP service account"
}

variable "master_ipv4_cidr_block" {
  type        = string
  default     = "172.36.0.32/28"
  description = "The /28 CIDR block to use for assigning private IP addresses to the cluster master(s) and the ILB VIP."
}

#--------------------------------------------------------------------#
# Optional variables
#--------------------------------------------------------------------#

variable "region" {
  type        = string
  default     = "us-east4"
  description = "The location (region or zone) in which the cluster master will be created."
}

variable "cluster_node_zones" {
  type        = list(string)
  default     = ["us-east4-a", "us-east4-b", "us-east4-c"]
  description = "The zones where Kubernetes cluster worker nodes should be located"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes latest version to use for managed workload cluster. Defaults to GKE Cluster Kubernetes version."
  default     = "1.27"
}

variable "gke_name" {
  type        = string
  description = "gke_name tag added for GKE resources"
  default     = "gke"
}

variable "network_name" {
  type        = string
  default     = "projects/corp-nonprod/global/networks/nonprod-vpc"
  description = "The name of the VPC network to which the cluster is connected."
}

variable "subnet_name" {
  type        = string
  default     = "projects/corp-nonprod/regions/us-east4/subnetworks/nonprod-default-sn"
  description = "The name of the VPC subnet in which the cluster's instances are launched."
}

variable "image_type" {
  type        = string
  default     = "UBUNTU_CONTAINERD"
  description = "The image type to use for the nodes in nodepool."
}

variable "machine_type" {
  type        = string
  default     = "e2-standard-16"
  description = "Single instance type to use for GKE worker nodes"
}

variable "initial_node_count" {
  type        = number
  default     = 1
  description = "Initial desired number of worker nodes per zone"
}

variable "min_node_count" {
  type        = number
  default     = 1
  description = "The Minimum number of worker nodes per zone in nodepool. Must be >=0 and <= max_node_count"
}

variable "max_node_count" {
  type        = number
  default     = 2
  description = "The Maximum number of worker nodes per zone in nodepool. Must be >= min_node_count"
}

variable "disk_size_gb" {
  type        = number
  default     = 100
  description = "The root disk size atached to each GKE worker nodes, specified in GB"
}

variable "disk_type" {
  type        = string
  default     = "pd-standard"
  description = "Type of the disk attached to each node (e.g. 'pd-standard', 'pd-balanced' or 'pd-ssd')."
}

variable "pods_ipv4_cidr_block" {
  type        = string
  default     = ""
  description = "The IP address range for the cluster pod IPs. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. /14) to have a range chosen with a specific netmask."
}

variable "services_ipv4_cidr_block" {
  type        = string
  default     = ""
  description = "The IP address range of the services IPs in this cluster. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. /14) to have a range chosen with a specific netmask."
}

variable "authorized_ipv4_cidr_block" {
  type        = string
  default     = "165.225.0.0/32"
  description = "External network that can access Kubernetes master through HTTPS. Must be specified in CIDR notation."
}

variable "access_token_file" {
  type = string
  default = ""
  description = "Google Cloud access token file location"
}

variable "master_authorized_networks_cidr_blocks" {
  type = list(map(string))
  default = [
    {
      cidr_block = "0.0.0.0/0"
      display_name = "default"
    },
  ]
}


variable "account_type" {
  description = "The account type"
  type        = string
  default     = "internal"
}

variable "host_project_id" {
  type        = string
  default     = "corp-nonprod"
  description = "The ID of the project to create resources in"
}

variable "secondary_ip_range_names" {
  description = "List of secondary IP range names"
  type        = list(string)
  default     = ["test-pods-2", "test-services-2"]
}
variable "cluster_secondary_range_name" {
  description = "The name of the secondary range for the cluster"
  type        = string
  default     = ""
}

variable "services_secondary_range_name" {
  description = "The name of the secondary range for the services"
  type        = string
  default     = ""
}
