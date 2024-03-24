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

variable "project" {
  type        = string
  default     = ""
  description = "The ID of the project to create resources in"
}

variable "cluster_name" {
  type        = string
  default     = ""
  description = "The name of the GKE cluster"
}

variable "region" {
  type        = string
  default     = "iua-west1"
  description = "The location (region or zone) in which the cluster master will be created."
}

variable "node_zones" {
  type        = list(string)
  default     = [""]
  description = "The zones where worker nodes are located"
}

variable "image_type" {
  type        = string
  default     = ""
  description = "The image type to use for the nodes in nodepool."
}

variable "machine_type" {
  type        = string
  default     = ""
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
  default     = ""
  description = "Type of the disk attached to each node (e.g. 'pd-standard', 'pd-balanced' or 'pd-ssd')."
}

variable "service_account" {
  type        = string
  default     = ""
  description = "The service account to use"
}

variable "build_number" {
  type        = string
  default     = "developer"
  description = "teamcity build number"
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
