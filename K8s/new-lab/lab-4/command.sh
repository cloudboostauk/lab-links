#Task 4 step 4.2
wget -q https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64 -O hey
chmod +x hey

./hey -z 120s -c 50 http://localhost:30080/products

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

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm repo add external-secrets https://charts.external-secrets.io

#Task 7 step 7.1
helm install external-secrets external-secrets/external-secrets \
  --namespace external-secrets \
  --create-namespace \
  --set installCRDs=true


#Task 7 step 7.3
kubectl create secret generic aws-credentials \
  --from-literal=access-key=YOUR_ACCESS_KEY \
  --from-literal=secret-key=YOUR_SECRET_KEY


#Task 7 step 7.6
  aws secretsmanager update-secret \
  --secret-id techstart/database \
  --secret-string '{"username":"techstart_admin","password":"NewSecurePassword2024!","host":"db.techstart.internal"}' \
  --region

#Task 8 step 8.2
kubectl get secret db-credentials -o jsonpath='{.data.username}' | base64 -d
kubectl get secret db-credentials -o jsonpath='{.data.password}' | base64 -d

#Task 8 step 8.5
kubectl annotate externalsecret database-credentials force-sync=$(date +%s) --overwrite

#Task 9 step 9.1
aws secretsmanager delete-secret \
  --secret-id techstart/database \
  --force-delete-without-recovery \
  --region 
