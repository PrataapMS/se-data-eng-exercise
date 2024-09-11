provider "google" {
  credentials = file("../keys/ee-india-se-data-1e178ab70497.json")
  project     = "ee-india-se-data"
  region      = "europe-west1"
}