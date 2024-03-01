#vpc
output vpc_name {
  value       = var.vpc_name
}

output subnetwork_name {
  value       = var.subnetwork_name
}

output vpc_id {
  value   = google_compute_network.vpc.id
}

output vpc_self_link {
  value   = google_compute_network.vpc.self_link
}

output subnet_self_link {
  value   = google_compute_subnetwork.subnet.self_link
}

#gke
output gke_id {
  value   = google_container_cluster.cluster.id
}

output google_container_cluster {
  value       = var.google_container_cluster.name
}