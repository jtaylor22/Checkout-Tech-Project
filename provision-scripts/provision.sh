#!/usr/bin/env bash
set -e

display_usage() {
  echo "Usage:
    <deployment-type>  - greenfield | infrastructure | website"
}

#ensures a positional parameters is provided
if [ $# -ne 1 ]; then
  display_usage
  exit 1
fi

# Colour variables for cleaner console outputs
reset=$(tput sgr0)
green=$(tput setaf 2)
script_location="$(dirname $(realpath "$0"))"

if [ $1 == "greenfield" ] || [ $1 == "infrastructure" ]
then
  # Clean up local environment prior to init
  echo "${green}Deleting local .terraform directory...${reset}"
  rm -rf $script_location/../terraform/cloudwatch/.terraform/

  # Terraform init
  echo "${green}Initialising terraform...${reset}"
  cd $script_location/../terraform/cloudfront
  terraform init

  # Terraform apply
  echo "${green}Applying terraform...${reset}"
  terraform apply
fi

if [ $1 == "greenfield" ] || [ $1 == "website" ]
then
  # Grab website content s3 bucket name
  cd $script_location/../terraform/cloudfront
  echo "${green}getting s3 bucket name...${reset}"
  s3Bucket=$(terraform output s3-bucket-name)

  # Upload website content
  echo "${green}uploading website content...${reset}"
  cd $script_location
  aws s3 sync --acl=public-read ../website-content/  s3://$s3Bucket
fi

cd $script_location
echo "${green}Complete!${reset}"
