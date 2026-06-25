az ad sp create-for-rbac \
  --name "sp-novapay-capstone" \
  --role Contributor \
  --scopes /subscriptions/<your-subscription-id>


az role assignment create \
  --assignee 34db439d-f298-41d0-a934-6397e0e06d9e \
  --role Contributor \
  --scope /subscriptions/<your-subscription-id>


az role assignment list --assignee 34db439d-f298-41d0-a934-6397e0e06d9e --all -o table


az storage account create \
  --name novapaytfstate$RANDOM \
  --resource-group rg-tfstate \
  --location westeurope \
  --sku Standard_LRS


az storage container create \
  --name tfstate \
  --account-name <the-name-from-step-2> \
  --auth-mode login


az role assignment create \
  --assignee-object-id $OBJECT_ID \
  --assignee-principal-type ServicePrincipal \
  --role "Reader" \
  --scope $SCOPE


az role assignment create \
  --assignee-object-id $OBJECT_ID \
  --assignee-principal-type ServicePrincipal \
  --role "Storage Blob Data Contributor" \
  --scope $SCOPE


az role assignment create \
  --assignee-object-id $OBJECT_ID \
  --assignee-principal-type ServicePrincipal \
  --role "Storage Account Key Operator Service Role" \
  --scope $SCOPE


az role assignment create \
  --assignee-object-id $OBJECT_ID \
  --assignee-principal-type ServicePrincipal \
  --role "Contributor" \
  --scope "/subscriptions/$SUBSCRIPTION"


az role assignment list \
  --assignee $OBJECT_ID \
  --output table
