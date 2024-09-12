resource "google_bigquery_table" "ratings_raw" {
  table_id   = "ratings_raw"
  dataset_id = google_bigquery_dataset.movies_data_prataap.dataset_id
  project    = google_bigquery_dataset.movies_data_prataap.project
  description = "This table contain raw movie ratings data"
  labels = {
    env = "default"
  }
  deletion_protection = false

  schema = jsonencode([
    {
      "name" = "userId"
      "type" = "STRING"
    },
    {
      "name" = "movieId"
      "type" = "STRING"
    },
    {
      "name" = "rating"
      "type" = "STRING"
    },
    {
      "name" = "timestamp"
      "type" = "STRING"
    },
    {
      "name" = "load_date"
      "type" = "DATETIME",
      "defaultValueExpression": "CURRENT_DATETIME"
    }
])
}
