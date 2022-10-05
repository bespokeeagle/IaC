data "google_project" "project" {
}

output "project_number" {
    value = data.google_project.project.number
}



resource "google_service_account" "default" {
    account_id   = var.service-account
    display_name = var.service-account
}

resource "google_container_cluster" "primary" {
    name     = var.name
    location = var.location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
    remove_default_node_pool = true
    initial_node_count       = 1
    workload_identity_config {
        workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
    }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
    name       = var.nodepool
    location   = var.location
    cluster    = google_container_cluster.primary.name
    node_count = 1

    node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    }

}
    
       

    
