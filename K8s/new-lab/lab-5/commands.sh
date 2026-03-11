#Task 2 step 2.3

# Install with custom values
helm install my-nginx bitnami/nginx \
  --set service.type=NodePort \
  --set service.nodePorts.http=30090


#Task 2 step 2.6
# Change replica count
helm upgrade my-nginx bitnami/nginx \
  --set service.type=NodePort \
  --set service.nodePorts.http=30090 \
  --set replicaCount=3

