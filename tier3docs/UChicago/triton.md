# Triton Inference Server (UChicago)

## Overview

The Triton Inference Server is deployed as a Kubernetes cluster service within
the UChicago Analysis Facility. This service provides high-performance AI model
inference with automatic scaling capabilities.

!!! info "Key Information"

    - **Access:** Internal to UChicago AF Kubernetes cluster only (not externally exposed)
    - **Endpoint:** `triton-traefik.triton.svc.cluster.local:8000`
    - **Version:** v2.61.0
    - **Autoscaling:** Managed by Horizontal Pod Autoscaler (HPA) based on average queue time metrics

The Triton service automatically scales the number of server instances based on
workload demand, ensuring efficient resource utilization.

## Accessing Triton

Access to the Triton Inference Server is currently restricted to services and
workloads running inside the UChicago AF Kubernetes cluster. If you need to
access Triton from your analysis workflows, you can connect to the load balancer
endpoint within the cluster environment.

**Load Balancer Endpoint:**

```
triton-traefik.triton.svc.cluster.local:8000
```

## Model Repository Access

All model repositories for Triton are hosted in an S3-compatible object storage
system managed by the UChicago Analysis Facility.

**S3 Storage URL:** `https://s3.af.uchicago.edu`

### Uploading Your Models

To upload and deploy your machine learning models on Triton, follow these steps:

#### 1. Request Access and Credentials

[Contact the UChicago AF administrators](../getting_help.md#facility-specific-support)
to request access to the S3 model repository.

Include in your request:

- Your UChicago AF username
- Brief description of your models and use case
- Expected storage requirements

#### 2. Create Your Model Directory

Once approved, you'll receive S3 credentials. Create a subdirectory in the
model repository using your AF username:

```bash
s3://triton-models/<your-username>/
```

This keeps your models organized and separates them from other users' models.

#### 3. Upload Models

Upload your models to your directory using any S3-compatible client:

=== "AWS CLI"

    ```bash
    aws s3 cp /path/to/your/model s3://triton-models/<your-username>/model-name/ --recursive
    ```

=== "s3cmd"

    ```bash
    s3cmd put /path/to/your/model s3://triton-models/<your-username>/model-name/ --recursive
    ```

=== "MinIO Client"

    ```bash
    mc cp --recursive /path/to/your/model s3/triton-models/<your-username>/model-name/
    ```

#### 4. Request Model Activation

After uploading your models,
[contact the AF administrators](../getting_help.md#facility-specific-support)
to have your models added to the Triton server configuration.

Include:

- Your username
- Model directory path
- Model name and type
- Any specific backend requirements (see below)

The Triton server polls the model repository every 60 seconds, so once
configured, your models should become available automatically.

## Requesting Additional Features

### Backend Support

Triton supports multiple machine learning frameworks and backends (TensorFlow,
PyTorch, ONNX, TensorRT, etc.). If you need support for a backend that is not
currently included in the UChicago Triton deployment, contact the AF
administrators.

**Required Information:**

- Backend/framework name (e.g., TensorFlow, PyTorch, ONNX)
- Framework version required
- Model type and format
- Expected use case

The AF team can deploy additional backends as extensions to the existing Triton
configuration.

### GPU Pinning

If your inference workloads require running models on a specific GPU model or
have special GPU requirements, you can request GPU affinity configuration.

**Required Information:**

- Preferred GPU model or node type
- Expected workload characteristics
- Resource requirements (GPU memory, compute)
- Performance requirements

The AF team can configure GPU affinity for your inference service to ensure
optimal performance.

## Support and Contact

For any questions, access requests, model configuration issues, or
troubleshooting assistance, please see the [Getting Help](../getting_help.md)
page for UChicago facility contact information.

---

**See Also:**

- [Triton Deployment Documentation](triton_deployment.md) - Technical details
  about the infrastructure and deployment configuration
- [Machine Learning Containers](../containers/ml/info.md) - For running ML
  training and other ML workloads
