# GKE
resource "google_container_cluster" "cluster" {
  name                     = var.google_container_cluster.name
  provider                 = google
  project                  = var.project_host
  location                 = var.region_host
  remove_default_node_pool = true
  initial_node_count       = var.google_container_cluster.initial_node_count
  default_max_pods_per_node = var.google_container_cluster.default_max_pods_per_node
  network                  = google_compute_network.vpc.self_link #how to refer another resource from diff module?
  subnetwork               = google_compute_subnetwork.subnet.self_link #how to refer another resource?
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"
  
  # Optional, if you want multi-zonal cluster
  # node_locations = [
  #   "asia-southeast2-c"
  # ]

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.ip_allocation_policy.cluster_secondary_range_name
    services_secondary_range_name = var.ip_allocation_policy.services_secondary_range_name
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.private_cluster_config.master_ipv4_cidr_block
    # peering_name            = google_compute_network_peering.peering1.name
  }

}

resource "google_container_node_pool" "general" {
  name       = var.google_container_node_pool.name
  provider   = google
  project = var.project_host
  cluster    = google_container_cluster.cluster.id
  node_count = var.google_container_node_pool.node_count

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = var.node_config.machine_type

    labels = {
      role = "general"
    }

    service_account = var.service_account_name
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}