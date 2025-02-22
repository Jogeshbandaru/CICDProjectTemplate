#!/bin/bash
# Exit immediately if any command fails
set -e

# Error handler: on any error, run terraform destroy and exit.
error_handler() {
  echo "Error detected. Running 'terraform destroy --auto-approve' to clean up..."
  terraform destroy --auto-approve
  exit 1
}

# Trap any error (non-zero exit status) and call the error_handler.
trap error_handler ERR

# Run Terraform commands sequentially.
echo "Initializing Terraform..."
terraform init

echo "Validating Terraform configuration..."
terraform validate

echo "Creating an execution plan..."
terraform plan

echo "Applying changes..."
terraform apply --auto-approve

echo "All commands executed successfully."
