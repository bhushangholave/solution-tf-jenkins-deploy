provider "google" {
  credentials = "${file("./creads/serviceaccount.json")}"
  project = "${var.ee-project-id}"
  region = "${var.ee-region}"
}