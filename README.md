### 📦 `k8s-CICD`

This repository contains Kubernetes manifests and CI/CD automation for deploying containerized applications.

---

### 🧰 Contents

- `StatefulSet` for MySQL
- `ConfigMap` & `Secrets` for environment variables
- Kubernetes `Service` objects
- `PersistentVolume` and `PVC` configuration
- Basic CI/CD structure

---

### 🚀 Getting Started

1. **Clone the repo:**

   ```bash
   git clone https://github.com/AbdallahBagato/k8s-CICD.git
   cd k8s-CICD
   ```

2. **Apply Kubernetes resources:**

   ```bash
   kubectl apply -f .
   ```

---

### 📌 Requirements

- [Minikube](https://minikube.sigs.k8s.io/)
- `kubectl`
- Docker

---

### 📄 License

This project is licensed under the MIT License.