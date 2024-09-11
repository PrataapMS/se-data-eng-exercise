resource "google_storage_bucket" "de_example_bucket" {
  name     = "se-data-landing-prataap"
  location = "europe-west1"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}

output "bucket_name" {
  value = google_storage_bucket.de_example_bucket.name
}
