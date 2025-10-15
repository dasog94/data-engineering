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

### Customization Notes

- **Custom Python packages:**  
  Extend the Airflow image with a custom Dockerfile and update `docker-compose.yaml` to use it.
- **Executor configuration:**  
  For simpler setups, switch to LocalExecutor and remove Redis/Airflow Worker from `docker-compose.yaml`.
- **Disable example DAGs:**  
  Configure via environment variables or `airflow.cfg` for a cleaner UI.
