#!/usr/bin/env bash
set -e

# Colour variables for cleaner console outputs
reset=$(tput sgr0)
green=$(tput setaf 2)
script_location="$(dirname $(realpath "$0"))"

# Grab website content s3 bucket name
cd $script_location/../terraform/cloudfront/
s3Bucket=$(terraform output s3-bucket-name)

# Empty website content s3 bucket
aws s3 rm s3://$s3Bucket --recursive

# Terraform Destroy
echo "Destroying terraform..."
terraform destroy
cd $script_location

echo "${green}Complete!${reset}"
