# AWS Cloud Static Website Deployment


## Prerequisites

- AWS Account
- AWS CLI installed
- Terraform installed

## AWS CLI Configuration

Before running Terraform, configure your AWS CLI with your credentials. This allows Terraform to interact with your AWS account.

### Step 1: Install AWS CLI

If you haven't already installed the AWS CLI, follow the instructions here: [AWS CLI Installation](https://aws.amazon.com/cli/)

### Step 2: Configure AWS CLI

Run the following command and enter your AWS credentials:

```bash
aws configure
```
- `AWS Access Key ID`: Enter your access key ID.
- `AWS Secret Access Key`: Enter your secret access key.
- `Default region name`: Enter your preferred AWS region (e.g., `us-east-1`).
- `Default output format`: Enter `json`.

## Clone repository

Clone the repository and change directory to it.

```bash
git clone https://github.com/VincentFinkenwirth/static-website-aws-s3-terraform.git
```
```bash
cd static-website-aws-s3-terraform
```


## Terraform Usage

With AWS CLI configured, you can now use Terraform to deploy your infrastructure.

### Step 1: Initialize Terraform
```bash
terraform init
```
### Step 2: Plan Terraform
```bash
terraform plan
```
### Step 3: Apply Terraform
```bash
terraform apply
```
- Enter `yes` to confirm the deployment.

### Step 4: Verify Deployment and retrieve URL
