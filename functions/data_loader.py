from google.cloud import bigquery


def load_csv_to_bigquery(file_name, bucket_name, table_ref):
    if not file_name.endswith('.csv'):
        print(f"Invalid file: {file_name}, skipped from processing.")
        return

    # Initialize client
    bigquery_client = bigquery.Client()

    # Define BigQuery dataset and table
    gcs_uri = f"gs://{bucket_name}/{file_name}"
    print(f"Loading {file_name} from {gcs_uri} to BigQuery")

    # Load data into BigQuery
    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.CSV,
        skip_leading_rows=1,
        autodetect=False,
        schema=get_schema_without_default_value_columns(bigquery_client, table_ref),
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,
    )

    # Load CSV data into BigQuery
    load_job = bigquery_client.load_table_from_uri(
        gcs_uri,
        table_ref,
        job_config=job_config
    )

    load_job.result()  # Wait for the job to complete.

    print("Job finished.")

    print(f"Loaded {load_job.output_rows} rows into {table_ref}.")


def get_schema_without_default_value_columns(bigquery_client, table_ref):
    default_value_columns = ["load_date"]
    schema = []
    for schema_field in bigquery_client.get_table(table_ref).schema:
        if schema_field.name not in default_value_columns:
            schema.append(
                bigquery.SchemaField(name=schema_field.name, field_type=schema_field.field_type, mode=schema_field.mode)
            )
    return schema
