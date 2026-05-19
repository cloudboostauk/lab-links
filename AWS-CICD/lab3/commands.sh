#Run the commands line by line

mkdir quickshop-infra

cd quickshop-infra

mkdir -p modules/app-environment

mkdir -p envs/dev

mkdir -p envs/prod

touch envs/dev/main.tf

touch envs/prod/main.tf

touch modules/app-environment/main.tf

touch modules/app-environment/variables.tf

touch modules/app-environment/outputs.tf
