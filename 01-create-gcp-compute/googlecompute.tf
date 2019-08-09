resource "google_compute_network" "vpc_network" {
  name                    = "${var.ee-network}"
  description             = "${var.ee-network-description}"
  project                 = "${var.ee-project-id}"
  auto_create_subnetworks = "false"
  routing_mode            = "${var.ee-network-routing-mode}"
}

resource "google_compute_subnetwork" "public-subnetwork" {
  name          = "${var.ee-subnetwork-public}"
  ip_cidr_range = "${var.ee-subnetwork-public-cidr}"
  region        = "${var.ee-region}"
  network       = "${google_compute_network.vpc_network.self_link}"
  project       = "${var.ee-project-id}"
}

#Private Subnet
resource "google_compute_subnetwork" "private-subnetwork" {
  name                     = "${var.ee-subnetwork-private}"
  ip_cidr_range            = "${var.ee-subnetwork-private-cidr}"
  region                   = "${var.ee-region}"
  network                  = "${google_compute_network.vpc_network.self_link}"
  project                  = "${var.ee-project-id}"
  private_ip_google_access = "true"
}

resource "google_compute_address" "ee_reserve_ip" {
  name         = "${var.ee-extip-jenkins}"
  region       = "${var.ee-region}"
  subnetwork   = "projects/${var.ee-project-id}/regions/${var.ee-region}/subnetworks/${var.ee-subnetwork-public}"
  project      = "${var.ee-project-id}"
}

resource "google_compute_firewall" "allow-jenkins-http" {
  name    = "${var.ee-firewall-tcp-8080}"
  network = "${google_compute_network.vpc_network.self_link}"
  project = "${var.ee-project-id}"

  allow {
    protocol = "${var.ee-firewall-tcp}"
    ports    = ["${var.ee-jenkins-port}"]
  }

  target_tags = ["${var.ee-tag-http}", "${var.ee-tag-jenkins}"]
}

resource "google_compute_firewall" "allow-bastion" {
  name    = "${var.ee-firewall-tcp-22}"
  network = "${google_compute_network.vpc_network.self_link}"
  project = "${var.ee-project-id}"

  allow {
    protocol = "${var.ee-firewall-tcp}"
    ports    = ["${var.ee-ssh-port}"]
  }

  target_tags = ["${var.ee-tag-ssh}"]
}

resource "google_compute_instance" "jenkins" {
  name                    = "${var.ee-node-jenkins-machinename}"
  machine_type            = "${var.ee-machinetype-jenkins}"
  zone                    = "${var.ee-zone}"
  tags                    = ["${var.ee-tag}", "${var.ee-tag-jenkins}", "${var.ee-tag-http}", "${var.ee-tag-ssh}"]
  metadata_startup_script = "${file("script.sh")}"
  project                 = "${var.ee-project-id}"

  boot_disk {
    initialize_params {
      image = "${var.ee-machine-image}"
    }
  }

  network_interface {
    network    = "${google_compute_network.vpc_network.self_link}"
    subnetwork = "${google_compute_subnetwork.public-subnetwork.self_link}"

    access_config {
      nat_ip = "${google_compute_address.ee_reserve_ip.address}"
      // Ephemeral IP
    }
  }

  metadata = {
    createdby = "${var.ee-metadata-tag}"
  }
}

resource "google_compute_instance" "app-node" {
  name                    = "${var.ee-node-app-machinename}"
  machine_type            = "${var.ee-machinetype-appnode}"
  zone                    = "${var.ee-zone}"
  tags                    = ["${var.tag-app-node}", "${var.ee-tag-ssh}"]
  metadata_startup_script = "${var.ee-machine-appnode-customscript}"
  project                 = "${var.ee-project-id}"

  boot_disk {
    initialize_params {
      image = "${var.ee-machine-image}"
    }
  }

  network_interface {
    network    = "${google_compute_network.vpc_network.self_link}"
    subnetwork = "${google_compute_subnetwork.private-subnetwork.self_link}"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    createdby = "${var.ee-metadata-tag}"
  }
}