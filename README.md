# Docker → Kubernetes Web App

A hands-on DevOps project demonstrating how to build a custom Docker image and deploy it to Kubernetes using Minikube.

## Project Overview

This project takes a custom Nginx Docker image, loads it into a local Minikube cluster, deploys it with a Kubernetes Deployment, runs two replicas, and verifies the application from a browser.

## Architecture

```text
Dockerfile
    ↓
docker build
    ↓
my-nginx:v1
    ↓
minikube image load
    ↓
Kubernetes Deployment
    ↓
2 Nginx Pods
    ↓
kubectl port-forward
    ↓
Browser
```

## Technologies

- Docker
- Kubernetes
- Minikube
- kubectl
- Nginx
- Linux

## Project Files

```text
.
├── Dockerfile
├── README.md
└── k8s
    └── deployment.yaml
```

## 1. Build the Docker Image

The Dockerfile uses `nginx:alpine` as the base image and replaces the default Nginx page with a custom message.

```bash
docker build -t my-nginx:v1 .
```

Verify:

```bash
docker images my-nginx
```

## 2. Load the Image into Minikube

Because the Kubernetes cluster is running in Minikube, the locally built image is loaded into Minikube:

```bash
minikube image load my-nginx:v1
```

Verify:

```bash
minikube image ls | grep my-nginx
```

## 3. Deploy to Kubernetes

Apply the Deployment:

```bash
kubectl apply -f k8s/deployment.yaml
```

Check the Deployment:

```bash
kubectl get deployment custom-nginx
```

Expected result:

```text
READY   UP-TO-DATE   AVAILABLE
2/2     2            2
```

Check the Pods:

```bash
kubectl get pods -l app=custom-nginx
```

Both Pods should reach `1/1 Running`.

## 4. Test the Application

Port-forward the Deployment to the local machine:

```bash
kubectl port-forward deployment/custom-nginx 8081:80
```

Open:

```text
http://localhost:8081
```

The browser should display:

```text
Hello from my custom Docker image!
```

## Key Kubernetes Concepts Demonstrated

- Kubernetes Deployment
- Replica management
- Pod creation and scheduling
- Local image loading with Minikube
- `imagePullPolicy: Never` for a locally loaded image
- Kubernetes label selectors
- Port forwarding
- Browser-based application verification

## Notes

This project is designed as a local learning/demo environment using Minikube. No cloud infrastructure is required.

No real passwords, API keys, or other credentials are stored in this repository.
