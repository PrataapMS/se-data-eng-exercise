resource "google_bigquery_table" "movies_raw" {
  table_id   = "movies_raw"
  dataset_id = google_bigquery_dataset.movies_data_prataap.dataset_id
  project    = google_bigquery_dataset.movies_data_prataap.project
  description = "This table contain raw movie data"
  labels = {
    env = "default"
  }
  deletion_protection = false

  schema = jsonencode([
    {
      "name" = "load_date"
      "type" = "DATETIME"
    },
    {
      "name" = "adult"
      "type" = "STRING"
    },
    {
      "name" = "belongs_to_collection"
      "type" = "STRING"
    },
    {
      "name" = "budget"
      "type" = "STRING"
    },
    {
      "name" = "genres"
      "type" = "STRING"
    },
    {
      "name" = "homepage"
      "type" = "STRING"
    },
    {
      "name" = "id"
      "type" = "STRING"
    },
    {
      "name" = "imdb_id"
      "type" = "STRING"
    },
    {
      "name" = "original_language"
      "type" = "STRING"
    },
    {
      "name" = "original_title"
      "type" = "STRING"
    },
    {
      "name" = "overview"
      "type" = "STRING"
    },
    {
      "name" = "popularity"
      "type" = "STRING"
    },
    {
      "name" = "poster_path"
      "type" = "STRING"
    },
    {
      "name" = "production_companies"
      "type" = "STRING"
    },
    {
      "name" = "production_countries"
      "type" = "STRING"
    },
    {
      "name" = "release_date"
      "type" = "STRING"
    },
    {
      "name" = "revenue"
      "type" = "STRING"
    },
    {
      "name" = "runtime"
      "type" = "STRING"
    },
    {
      "name" = "spoken_languages"
      "type" = "STRING"
    },
    {
      "name" = "status"
      "type" = "STRING"
    },
    {
      "name" = "tagline"
      "type" = "STRING"
    },
    {
      "name" = "title"
      "type" = "STRING"
    },
    {
      "name" = "video"
      "type" = "STRING"
    },
    {
      "name" = "vote_average"
      "type" = "STRING"
    },
    {
      "name" = "vote_count"
      "type" = "STRING"
    }
])
}
