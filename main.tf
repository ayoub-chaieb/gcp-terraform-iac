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
    tags         = ["web", "dev"]

    boot_disk {
        initialize_params {
            image = "cos-cloud/cos-stable"
        }
    }

    network_interface {
        network = google_compute_network.vpc_network.self_link
        access_config {
            nat_ip = google_compute_address.vm_static_ip.address
        }
    }
}

resource "google_compute_address" "vm_static_ip" {
    name = "terraform-static-ip"
}

resource "google_storage_bucket" "example_bucket" {
    name     = "qwiklabs-gcp-02-e97b910423c8"
    location = "US"

    website {
        main_page_suffix = "index.html"
        not_found_page   = "404.html"
    }
}

resource "google_compute_instance" "another_instance" {
    depends_on   = [google_storage_bucket.example_bucket]
    name         = "terraform-instance-2"
    machine_type = "e2-micro"

    boot_disk {
        initialize_params {
            image = "cos-cloud/cos-stable"
        }
    }

    network_interface {
        network = google_compute_network.vpc_network.self_link
        access_config {
        }
    }
}
