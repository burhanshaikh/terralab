This repository contains the solution to the Terraform assignment : https://github.com/infracloudio/associate-sre-lab/tree/main/terraform

For remote state storage S3 has been used and for state locking DynamoDB has been used.
Before applying terraform init, plan and apply, please make sure to provision an S3 bucket and a DynamoDB table and update the names in the provider.tf file.

AWS Credentials have been configured using the AWS CLI and Terraform directly picks them up.