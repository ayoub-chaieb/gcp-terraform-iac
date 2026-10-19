terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "3.5.0"
        }
  }
}

provider "google" {

    project = "qwiklabs-gcp-02-e97b910423c8"
    region  = "us-central1"
    zone    = "us-central1-b"
}

resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
}
