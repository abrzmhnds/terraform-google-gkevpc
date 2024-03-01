# VPC
variable "vpc_name" {}

variable "project_network" {}

variable "subnetwork_name" {}

variable "region_network" {}

# GKE
variable "google_compute_subnetwork" {
  type = object({
    ip_cidr_range        = string
  })
}

variable "project_host" {}
variable "region_host" {}

variable "secondary_ip_range" {
  type = object({
    first_range_name        = string
    first_ip_cidr_range     = string
    second_range_name       = string
    second_ip_cidr_range    = string
  })
}

variable "google_container_cluster" {
  type = object({
    name                        = string
    initial_node_count          = number
    default_max_pods_per_node   = number
  })
}

variable "ip_allocation_policy" {
  type = object({
    cluster_secondary_range_name  = string
    services_secondary_range_name = string
  })
}

variable "private_cluster_config" {
  type = object({
    master_ipv4_cidr_block      = string
  })
}

variable "service_account_name" {}

# variable "vpc_attach" {
#   type = string
# }

variable "google_container_node_pool" {
  type = object({
    name                = string
    node_count          = number
  })
}

variable "node_config" {
  type = object({
    machine_type    = string
  })
}
