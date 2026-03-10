#Task 6 step 6.2
aws secretsmanager create-secret \
  --name techstart/database \
  --description "TechStart database credentials" \
  --secret-string '{"username":"techstart_admin","password":"BlackFriday2024!","host":"db.techstart.internal"}' \
  --region eu-west-2


#Task 6 step 6.3
aws secretsmanager get-secret-value \
  --secret-id techstart/database \
  --region eu-west-2

#Task 7 step 7.1
helm install external-secrets external-secrets/external-secrets \
  --namespace external-secrets \
  --create-namespace \
  --set installCRDs=true

#Task 7 step 7.6
  aws secretsmanager update-secret \
  --secret-id techstart/database \
  --secret-string '{"username":"techstart_admin","password":"NewSecurePassword2024!","host":"db.techstart.internal"}' \
  --region