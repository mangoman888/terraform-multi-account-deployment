# terraform-multi-account-deployment
Deploy Terraform Config to multiple AWS accounts using a Make file

**For AWS modules**

* _Terraform workspaces_ at time of writing, seems better suited for deploying multiple evvironments to the same AWS account.  We needed a way to deploy to environments that are in different AWS accounts without duplicating code. 

* The solution for now is to use a makefile.

# How to run
 
*  **Requires 3 Options**

	*  **env** (the deployment environment i.e. _dev|staging|prod_)

	*  **region** (the aws region of the remote state s3 bucket)

	*  **profile** (the aws profile to use for this deployment)

**NB**

* If you want to use this makefile as an example for your own collection of terraform config:
	* Make a copy of it in the root of your terraform config directory.
	* _**Change**_ the `-backend-config="key=xxx` path to be unique, i.e. `"key=my-terraform-config/$(env).tfstate"`
	* The assumption is you have a S3 backend for remote state already set up.

**Run examples**
*  _Example Dev environment run_

	*  `make plan env=dev region=eu-west-2 profile=yourDevProfile`

	*  `make apply env=dev region=eu-west-2 profile=yourDevProfile`

*  _Example Staging environment run_

	*  `make plan env=staging region=us-east-1 profile=yourStagingProfile`

	*  `make apply env=staging region=us-east-1 profile=yourStagingProfile`