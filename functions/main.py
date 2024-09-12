from config import *
from data_loader import load_csv_to_bigquery


def main(event, context):

    file = event
    bucket_name = file['bucket']
    file_name = file['name']

    if file_name.startswith('movies'):
        load_csv_to_bigquery(file_name, bucket_name, movies_table_ref)
    elif file_name.startswith('movies'):
        load_csv_to_bigquery(file_name, bucket_name, ratings_table_ref)
    else:
        print("File name doesn't start with 'movies' or 'rating'")
