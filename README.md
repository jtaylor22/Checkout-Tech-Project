# Checkout Ltd Static Website Project

## Description
This project manages the configuration to build and deploy a static website in AWS. The following AWS services are used: 

1. S3 - host the website content
2. Cloudfront - Content Delivery Network 
3. Cloudwatch - Metrics and Alerting

### Diagram
![](https://i.imgur.com/FhPY8VM.png)

## Deployment
The deployment process is very simple and managed completely by a single bash script. There are three different deployment scenarios:
1. Greenfield Deployment
2. Infrastructure Deployment
3. Website Deployment

### Prereqs
* Terraform v0.12 - [Installation Guide](https://learn.hashicorp.com/terraform/getting-started/install.html)
* AWSCLI - [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
* IAM User with AWS S3 Access - [Access Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

### Greenfield Deployment
The Greenfield Deployment will build all of our infrastructure via Terraform and upload the website content to S3 via the AWSCLI.
```
cd ~/Checkout-Tech-Project/provision-scripts/
./provision.sh greenfield
```

### Infrastructure Deployment
The Infrastructure Deployment will build all of our infrastructure via Terraform. Use this deployment method when you only want to make infrastructure changes.
```
cd ~/Checkout-Tech-Project/provision-scripts/
./provision.sh infrastructure
```

### Website Deployment
The Website Deployment will upload all of our website content into an S3 bucket using the AWSCLI. Use this deployment method when you want to make changes to the website or upload content.
```
cd ~/Checkout-Tech-Project/provision-scripts/
./provision.sh website
```

## Scaleability
We don't need to worry about scaleability; Cloudfront does that for us! It is able to handle over 5PB of data transfer, with the first 50gb free of charge. The free tier alone is able to handle up to 2,000,000 HTTP OR HTTPS requests per month. The service is also on-demand, meaning we only pay for what we use. See the following documents for more information on Cloudfront and Pricing:
* [Cloudfront](https://aws.amazon.com/cloudfront/)
* [Pricing](https://aws.amazon.com/cloudfront/pricing/)

## Monitoring & Alerting
Cloudfront provides its own metrics by default and works seamlessly with CloudWatch for Alerting. For this project, a user-requests-alarm is created as a demonstration.
