ifndef env
$(error env is not set)
endif

ifndef region
$(error region is not set)
endif

ifndef profile
$(error profile is not set)
endif

export AWS_PROFILE=$(profile)
export AWS_DEFAULT_REGION=$(region)

init:
	rm -rf .terraform
	terraform init \
		-backend-config="bucket=mybucket-$(env)-statestore" \
		-backend-config="key=mypath/$(env).tfstate" \
		-backend-config="region=$(AWS_DEFAULT_REGION)" \
		-backend-config="encrypt=true" \
		-backend-config="dynamodb_table=myddbtable-$(env)-statestore-lck"

plan: init
	terraform plan -var-file=tfvars/$(env).tfvars -out=plan.tfplan

apply: init
	terraform apply -input=false plan.tfplan