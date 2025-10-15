# Guide: Installing uv & Migrating requirements.txt to pyproject.toml

## 1. Install uv

Install uv on WSL, Linux, or macOS using the following command:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## 2. Initialize project and a virtual environment
Create a virtual environment using uv

```bash
PROJECT_NAME="airflow-project"
PYTHON_VERSION=$(grep '^PYTHON_VERSION=' .env | cut -d '=' -f2)
uv python install $PYTHON_VERSION
uv python pin $PYTHON_VERSION
uv init --name ${PROJECT_NAME} --bare
uv venv
```

## 3. Download packages
This script installs Apache Airflow with a specified version and its dependencies based on the Python version in use.
For example this would install 3.0.0 with python 3.10: https://raw.githubusercontent.com/apache/airflow/constraints-3.1.0/constraints-3.10.txt

```bash
AIRFLOW_VERSION=$(grep '^AIRFLOW_VERSION=' .env | cut -d '=' -f2)
PYTHON_VERSION=$(grep '^PYTHON_VERSION=' .env | cut -d '=' -f2)
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
uv add "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"
```

## 4. Set python interpreter
Set the Python interpreter for your IDE to the one created by uv
The path will be something like `~/.virtualenvs/${PROJECT_NAME}/bin/python`
