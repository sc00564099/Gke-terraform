variable "name_prefix" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
}

variable "stage" {
  type        = string
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'cluster'"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `name_prefix`, `stage`, etc."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}


variable "region" {
  type        = string
  default     = ""
  description = "The location (region or zone) in which the cluster master will be created."
}

variable "kubernetes_version" {
  type        = string
  default     = ""
  description = "Kubernetes latest version to use for managed workload cluster. Defaults to GKE Cluster Kubernetes version."
}

variable "network_name" {
  type        = string
  default     = ""
  description = "The name of the VPC network to which the cluster is connected." 
}

variable "subnet_name" {
  type        = string
  default     = ""
  description = "The name of the VPC subnet in which the cluster's instances are launched." 
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
  default     = ""
  description = "External network that can access Kubernetes master through HTTPS. Must be specified in CIDR notation."
}

variable "master_ipv4_cidr_block" {
  type        = string
  default     = ""
  description = "The /28 CIDR block to use for assigning private IP addresses to the cluster master(s) and the ILB VIP."
}

variable "master_authorized_networks_cidr_blocks" {
  type = list(map(string))
  default = [
    {
      # External network that can access Kubernetes master through HTTPS. Must
      # be specified in CIDR notation. This block should allow access from any
      # address, but is given explicitly to prevent Google's defaults from
      # fighting with Terraform.
      cidr_block = "0.0.0.0/0"     
      # Field for users to identify CIDR blocks.
      display_name = "default"
    },
  ]
}

variable "build_number" {
  type        = string
  default     = "developer" 
  description = "build number"
}

variable "it_owner" {
  type        = string
  default     = "IT_OWNER"
  description = "It owner (email) for id for resources"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "account_type" {
  description = "The account type"
  type        = string
  default     = "external"
}

variable "host_project_id" {
  type        = string
  default     = ""
  description = "The ID of the project to create resources in"
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

variable "secondary_ip_range_names" {
  description = "List of secondary IP range names"
  type        = list(string)
  default     = ["bpo-test-pods-2", "bpo-test-services-2"]
}
