# 🚀 KOPS Kubernetes Cluster Setup on AWS

## 📌 Prerequisites

- AWS EC2 Instance
- S3 Bucket (same region as EC2)
- IAM User with Administrator Access
- Ubuntu/Linux Server

---

# ☁️ Step 0: Create S3 Bucket

Create S3 bucket:

```text
<bucket-name>.k8s.local
```

Example:

```text
devops-k8s-state.k8s.local
```

---

# 🔐 Step 1: Create IAM User

Navigate:

```text
AWS Console → IAM → Users → Create User
```

Configuration:

| Field | Value |
|------|------|
| Username | kops |
| Permission | AdministratorAccess |

---

# 🔑 Generate Access Keys

Navigate:

```text
IAM User → Security Credentials → Create Access Keys
```

Select:

```text
CLI
```

Download:
- Access Key
- Secret Access Key

---

# ⚙️ Install AWS CLI

```bash
sudo apt update -y

sudo apt install unzip -y

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install
```

---

# 🔧 Configure AWS CLI

```bash
aws configure
```

Provide:
- AWS Access Key
- AWS Secret Key
- Region
- Output Format

---

# ⚙️ Step 2: Install kubectl & KOPS

## Install kubectl

```bash
curl -LO https://dl.k8s.io/release/v1.35.0/bin/linux/amd64/kubectl
```

---

## Install KOPS

```bash
wget https://github.com/kubernetes/kops/releases/download/v1.25.0/kops-linux-amd64
```

---

## Give Execute Permissions

```bash
chmod +x kops-linux-amd64 kubectl
```

---

## Move Binaries

```bash
sudo mv kubectl /usr/local/bin/kubectl

sudo mv kops-linux-amd64 /usr/local/bin/kops
```

---

# 🌐 Configure KOPS State Store

```bash
export KOPS_STATE_STORE=s3://<bucket-name>.k8s.local
```

Example:

```bash
export KOPS_STATE_STORE=s3://devops-k8s-state.k8s.local
```

---

# 🚀 Step 3: Create Kubernetes Cluster

```bash
kops create cluster \
--name devops.k8s.local \
--zones us-east-1a \
--master-image ami-xxxxxxxx \
--master-count 1 \
--master-size t3.medium \
--node-image ami-xxxxxxxx \
--node-count 2 \
--node-size t3.medium
```

---

# 🔄 Apply Cluster Configuration

```bash
kops update cluster --name devops.k8s.local --yes --admin
```

---

# ✅ Validate Cluster

```bash
kops validate cluster --wait 10m
```
