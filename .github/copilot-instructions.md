# Copilot Instructions for crudapp-k8s

## Project Overview
This repository contains a Kubernetes-based CRUD application composed of multiple services:
- **backend/**: Contains deployment manifests for the main backend and worker services.
- **frontend/**: Contains deployment manifest for the frontend service.
- **mongo/**: Manifests for MongoDB initialization and statefulset.
- **redis/**: Manifests for Redis configuration, initialization, and statefulset.

## Architecture & Data Flow
- The application is designed for microservices deployment on Kubernetes.
- **Backend** and **worker** services are deployed separately and likely communicate via internal networking.
- **Frontend** service interacts with backend APIs.
- **MongoDB** and **Redis** are deployed as statefulsets, with init jobs for setup.
- Data flows from frontend → backend → MongoDB/Redis.

## Developer Workflows
- **Deployment:**
  - Apply manifests using `kubectl apply -f <manifest.yaml>` for each service/component.
  - Update deployments by editing the respective YAML files and re-applying.
- **Debugging:**
  - Use `kubectl logs <pod>` to inspect logs for backend, worker, frontend, mongo, and redis pods.
  - For statefulsets, use `kubectl get pods -l app=<name>` to list relevant pods.
- **Configuration:**
  - Redis uses a ConfigMap (`redis-configmap.yaml`).
  - MongoDB and Redis have init jobs for database setup.

## Project-Specific Patterns
- All service manifests are organized by component in top-level folders.
- Each service has its own deployment YAML; stateful services (MongoDB, Redis) use statefulsets and init jobs.
- No monolithic manifest; deployments are modular and independently managed.
- No custom build/test scripts detected; focus is on Kubernetes resource management.

## Integration Points
- **MongoDB**: Initialized via `mongo-init-job.yaml`, managed as a statefulset.
- **Redis**: Configured via `redis-configmap.yaml`, initialized via `redis-init-job.yaml`, managed as a statefulset.
- **Backend/Worker**: Likely communicate internally; check deployment YAMLs for environment variables and service links.
- **Frontend**: Connects to backend via service endpoint defined in deployment manifest.

## Examples
- To deploy the backend: `kubectl apply -f backend/backend-deployment.yaml`
- To view logs for the frontend: `kubectl logs <frontend-pod-name>`
- To update Redis config: Edit `redis/redis-configmap.yaml` and re-apply

## Key Files
- `backend/backend-deployment.yaml`, `backend/worker-deployment.yaml`
- `frontend/frontend-deployment.yaml`
- `mongo/mongo-init-job.yaml`, `mongo/mongo-statefulset.yaml`
- `redis/redis-configmap.yaml`, `redis/redis-init-job.yaml`, `redis/redis-statefulset.yaml`

---
**Note:** No existing AI agent instructions or README detected. This file should be updated if new conventions or workflows are added.
