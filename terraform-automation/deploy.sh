#!/bin/bash

echo "============================="
echo " Terraform EC2 Deployment"
echo "============================="

# Step 1: Initialize Terraform
echo "[1/5] Initializing Terraform..."
terraform init


# Step 2: Validate Terraform files
echo "[2/5] Validating Terraform configuration..."
terraform validate

# Step 3: Apply Terraform (Auto approve)
echo "[3/5] Applying Terraform..."
terraform apply -auto-approve

# Step 4: Capture outputs
echo "[4/5] Fetching Terraform outputs..."

PUBLIC_IP=$(terraform output -raw public_ip)
KEY_FILE=$(terraform output -raw private_key_file)

echo "Public IP: $PUBLIC_IP"
echo "Private key downloaded at: $KEY_FILE"

# Step 5: Change key permission (optional safety)
chmod 400 $KEY_FILE

echo "============================="
echo " Deployment Complete!"
echo "============================="


echo " You can now connect via:"
echo " ssh -i $KEY_FILE ubuntu@$PUBLIC_IP"
echo "============================="

echo "[4] Running Ansible automation..."
cd ../ansible
./run_ansible.sh

echo "====================================="
echo " Lab Completed Successfully!"
echo "====================================="
