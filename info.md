# The backend.tf file configures remote state storage for Terraform.

Instead of storing the **terraform.tfstate** file locally, it stores it in an **AWS S3 bucket**, while **DynamoDB** provides state locking to prevent multiple users or CI/CD jobs from modifying the infrastructure simultaneously.

# Explanation
# Parameter	                                    Description
bucket	            -                S3 bucket for storing the Terraform state
key	                -                Path/name of the state file inside the bucket
region	            -                 AWS Region
dynamodb_table	    -                 Table used for state locking
encrypt	            -                 Encrypts the state file in S3

# Important Bootstrap Note

There is one important Terraform limitation:

The **S3 bucket** and **DynamoDB table** must already exist before Terraform can use them as its backend.
Terraform cannot initialize a backend that it is trying to create at the same time.

A common enterprise approach is:

Bootstrap phase (local state):
Create the S3 bucket.
Create the DynamoDB table.
Migration phase:
Add backend.tf.

Run:

$ terraform init -migrate-state

Terraform moves the local state into the S3 backend.

This is the standard pattern used in enterprise Terraform deployments and CI/CD pipelines.


# After terraform apply, the output will resemble:

arn:aws:iam::123456789012:role/GitHubActionsOIDCRole

Use this ARN in your GitHub Actions workflow.

