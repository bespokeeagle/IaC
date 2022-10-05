variable "service-account" {
    type = string
    description = "service account id and name"
    default = "development-cluster"
}

variable "name" {
    type = string
    description = "cluster name"
    default = "development"
}

variable "nodepool" {
    type = string
    description = "nodepool name"
    default = "development"
}

variable "location" {
    type = string
    description = "data center where resources reside"
    default = "us-central1"
  
}

variable "project_id" {
    type = string
    description = "my GCP Project ID"
    default = "sonic-cat-364518"
  
}