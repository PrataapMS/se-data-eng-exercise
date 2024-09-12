resource "google_cloudfunctions_function" "process_file" {
  name        = "process-movies-data-function"
  description = "Function to process new data uploaded to the movies bucket"
  runtime     = "python310"
  entry_point = "main"

  source_archive_bucket = google_storage_bucket.de_example_bucket.name
  source_archive_object = google_storage_bucket_object.movies_data_loader.name

  environment_variables = {
  }

  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = google_storage_bucket.de_example_bucket.name
  }
}

resource "google_storage_bucket_object" "movies_data_loader" {
  name   = "movies-data-loader-function"
  bucket = google_storage_bucket.de_example_bucket.name
  source = "../functions/package/movies-data-loader-function.zip"
}