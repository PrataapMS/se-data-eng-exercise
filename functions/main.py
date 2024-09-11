import os
import datetime
from google.cloud import storage, bigquery
import logging

def load_csv_to_bigquery(file_name, bucket_name):
    if not file_name.endswith('.csv'):
        logging.info(f"Invalid file: {file_name}, skipped from processing.")
        return

    # Extract timestamp from file name
    timestamp_str = file_name[7:-4]  # Remove 'movies_' prefix and '.csv' suffix
    try:
        timestamp = datetime.datetime.strptime(timestamp_str, "%Y%m%d%H_%M_%S")
    except ValueError:
        logging.info(f"Invalid timestamp in file name: {file_name}. Skipping.")
        return

    # Initialize clients
    storage_client = storage.Client()
    bigquery_client = bigquery.Client()

    logging.info(f"Loading data from {file_name}")

    # Download the CSV file from the bucket
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)

    logging.info(f"Loaded data from {file_name}")

    # Define BigQuery dataset and table
    dataset_id = 'movies_data'
    table_id = 'movies_raw'
    table_ref = bigquery_client.dataset(dataset_id).table(table_id)

    logging.info(f"Loading {file_name} to BigQuery.")

    # Load data into BigQuery
    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.CSV,
        skip_leading_rows=1,
        autodetect=True,
        ignore_unknown_values=True,
        write_disposition=bigquery.WriteDisposition.WRITE_APPEND
    )

    # Load CSV data into BigQuery
    with blob.open("r") as source_file:
        job = bigquery_client.load_table_from_file(source_file, table_ref, job_config=job_config)

    logging.info("Job loaded.")

    job.result()  # Wait for the job to complete.

    logging.info("Job finished.")

    logging.info(f"Loaded {job.output_rows} rows into {dataset_id}:{table_id}.")

def main(event, context):

    file = event
    bucket_name = file['bucket']
    file_name = file['name']

    load_csv_to_bigquery(file_name, bucket_name)
