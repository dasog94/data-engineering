FROM ${AIRFLOW_IMAGE_NAME}

# Support for uv as installation tool is experimental from 2.9.0
COPY pyproject.toml /tmp/pyproject.toml
RUN uv pip install -r /tmp/pyproject.toml