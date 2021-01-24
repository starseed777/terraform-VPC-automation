This repository contains terraform files used to automate a provisioning of an AWS VPC environment with all of the necessary networking components
and various other resources. Backend configured s3 bucket for automated backups of the terraform tfstate file + dynamoDB state locking.
Resources provisioned include all the necessary security group configurations for each resource along with an RDS database, apache webservers, application load balancer and IAM policies / roles for s3 access.

Debugging for s3 logs can be found in the repository named s3-logs-terraform-debug 
