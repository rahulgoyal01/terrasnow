ifdef CI
	export NO_SSL=GIT_SSL_NO_VERIFY=true
	export COMPOSE_INTERACTIVE_NO_CLI=1
else
	export TERRAFORM_WORKSPACE=snowflake_dev
	export NO_SSL=GIT_SSL_NO_VERIFY=false
	export COMPOSE_INTERACTIVE_NO_CLI=1
endif

init: .env
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" init'
.PHONY: init

########################### DEV ########################################

plan_dev: init workspace
	docker-compose run --rm envvars ensure --tags terraform
# 	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" state list'
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" plan'
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/dev1" plan'
.PHONY: plan_dev

applyAuto_dev: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" apply -auto-approve'
.PHONY: applyAuto_dev

########################### TEST #########################################

plan_test: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" plan'
.PHONY: plan_test

applyAuto_test: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" apply -auto-approve'
.PHONY: applyAuto_test

########################### PROD #########################################

plan_prod: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" plan'
.PHONY: plan_prod

applyAuto_prod: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" apply -auto-approve'
.PHONY: applyAuto_prod

######################################################################################################################

validate: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'terraform fmt -check=true || (echo -e "\e[1;31mFailure! \e[0m\033[0mThe above files need formatting."; exit 3)'
.PHONY: validate

apply: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" apply'
.PHONY: apply

destroy: .env init workspace
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'terraform destroy'
.PHONY: destroy

workspace: .env
	docker-compose run --rm envvars ensure --tags terraform
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" workspace new $(TERRAFORM_WORKSPACE); true'
	docker-compose run --rm terraform-utils sh -c 'terraform -chdir="./stacks/${env}" workspace select $(TERRAFORM_WORKSPACE)'
.PHONY: workspace

lsworkspace: .env init
	docker-compose run --rm terraform-utils sh -c 'terraform workspace list'
.PHONY: lsworkspace

.env:
	touch .env
	docker-compose run --rm envvars validate
	docker-compose run --rm envvars envfile --overwrite
.PHONY: .env

shell: .env
	docker-compose run --rm terraform-utils sh
.PHONY: shell