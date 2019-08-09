output "reserve_jenkins_ip_name" {
  value = "${google_compute_address.ee_reserve_ip.name}"
}

output "reserve_external_ip" {
  value = "${google_compute_address.ee_reserve_ip.address}"
}

output "ee_google_compute_appnode_name" {
  value = "${google_compute_instance.app-node.name}"
}

output "ee_google_compute_jenkins_name" {
  value = "${google_compute_instance.jenkins.name}"
}

output "ee_google_compute_network_name" {
  value = "${google_compute_network.vpc_network.name}"
}

output "ee_google_compute_publicsubnetwork_name" {
  value = "${google_compute_subnetwork.public-subnetwork.name}"
}

output "ee_google_compute_privatesubnetwork_name" {
  value = "${google_compute_subnetwork.private-subnetwork.name}"
}