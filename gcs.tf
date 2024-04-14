resource "google_storage_bucket" "bucket" {
  name     = "${var.project_id}-my-bucket"
  location = "us-central1"
}