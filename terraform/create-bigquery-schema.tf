resource "google_bigquery_dataset" "movies_data_prataap" {
  dataset_id = "movies_data_prataap"
  project    = "ee-india-se-data"

  description = "Dataset to store movies data"
  location    = "europe-west1"

}