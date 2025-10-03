# Apache Airflow 3.1 Docker Compose Setup

## 1. Environment Preparation

- **Install Docker Desktop** (includes Docker Compose)
- **Create project directory:**
  ```bash
  mkdir airflow-docker
  cd airflow-docker
  ```
- **Download official Docker Compose file:**
  ```bash
  curl -LfO 'https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml'
  ```
- **Create required directories:**
  ```bash
  mkdir -p ./dags ./logs ./plugins ./config
  ```
- **Set Airflow User ID for permissions:**
  ```bash
  echo -e "AIRFLOW_UID=$(id -u)" > .env
  ```

## 2. Initialize Airflow Database

- Run initialization:
  ```bash
  docker-compose up airflow-init
  ```
- Default admin credentials: `airflow/airflow`

## 3. Launch Airflow Services

- Start all services in detached mode:
  ```bash
  docker-compose up -d
  ```

## 4. Access Airflow UI

- Open [http://localhost:8080](http://localhost:8080)
- Login:  
  - Username: `airflow`  
  - Password: `airflow`

## 5. Develop and Manage DAGs

- Place DAG files in `./dags` directory

---

# Local Airflow Development with uv

If you want to run Airflow locally (not in Docker), follow these steps:

1. Ensure you have Python 3.10, 3.11, 3.12, or 3.13 installed.
2. Create a virtual environment and install dependencies using uv:
   ```bash
   uv venv .venv
   uv venv update
   ```
3. Airflow is listed in pyproject.toml for visibility, but must be installed with constraints for compatibility. Run:
   ```bash
   ./install_library.sh
   ```
   This script installs Airflow with the correct constraints for your Python version.
4. After installation, you can start Airflow:
   ```bash
   airflow standalone
   ```
5. Access the Airflow UI at [http://localhost:8080](http://localhost:8080)

**Note:** Always run `install_library.sh` after updating your environment with uv to ensure Airflow is installed correctly.

---

### Customization Notes

- **Custom Python packages:**  
  Extend the Airflow image with a custom Dockerfile and update `docker-compose.yaml` to use it.
- **Executor configuration:**  
  For simpler setups, switch to LocalExecutor and remove Redis/Airflow Worker from `docker-compose.yaml`.
- **Disable example DAGs:**  
  Configure via environment variables or `airflow.cfg` for a cleaner UI.
