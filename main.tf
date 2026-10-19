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

resource "google_compute_instance" "vm_instance" {
    name         = "terraform-instance"
    machine_type = "e2-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-12"
        }
    }

    network_interface {
        network = google_compute_network.vpc_network.self_link
        access_config {
        }
    }
}
