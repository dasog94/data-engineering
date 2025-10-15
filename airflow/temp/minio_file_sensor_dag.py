from airflow import DAG
from airflow.providers.amazon.aws.sensors.s3 import S3KeySensor
from airflow.operators.dummy import DummyOperator
from datetime import datetime, timedelta

# DAG configuration
DAG_ID = 'minio_file_sensor_dag'
BUCKET_NAME = 'your-minio-bucket'  # Change to your MinIO bucket name
KEY_PREFIX = 'monitoring/'         # Change to your file prefix if needed
S3_CONN_ID = 'minio_s3_conn'      # Airflow connection ID for MinIO (S3-compatible)

with DAG(
    dag_id=DAG_ID,
    start_date=datetime(2023, 1, 1),
    schedule_interval='@once',
    catchup=False,
    default_args={
        'retries': 1,
        'retry_delay': timedelta(minutes=5),
    },
    tags=['minio', 'sensor', 'monitoring'],
) as dag:

    wait_for_file = S3KeySensor(
        task_id='wait_for_new_file',
        bucket_key=f'{KEY_PREFIX}*',
        bucket_name=BUCKET_NAME,
        aws_conn_id=S3_CONN_ID,
        wildcard_match=True,
        poke_interval=60,
        timeout=60 * 60,  # 1 hour
    )

    process_file = DummyOperator(
        task_id='process_file'
    )

    wait_for_file >> process_file

