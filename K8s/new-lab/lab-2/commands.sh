#Task 1 step 1.3
POD_IP=$(kubectl get pod -l app=techstart -o jsonpath='{.items[0].status.podIP}')
echo "Pod IP: $POD_IP"

#Task 1 step 1.4
POD_NAME=$(kubectl get pod -l app=techstart -o jsonpath='{.items[0].metadata.name}')

#Task 2 step 2.3
CLUSTER_IP=$(kubectl get service catalog-service -o jsonpath='{.spec.clusterIP}')
echo "Service IP: $CLUSTER_IP"

#Task 2 step 2.3
kubectl run test-pod --image=curlimages/curl --rm -it --restart=Never -- curl http://$CLUSTER_IP/

#Task 2 step 2.4
kubectl run test-pod --image=curlimages/curl --rm -it --restart=Never -- curl http://catalog-service/

#Task 3 step 3.3
EC2_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
echo "Access your app at: http://$EC2_IP:30080"

#Task 4 step 4.2
kubectl describe service catalog-service | grep -A2 Selector

#Task 4 step 4.4
POD_NAME=$(kubectl get pod -l app=techstart -o jsonpath='{.items[0].metadata.name}')

#Task 5 step 5.1
sudo docker build -t techstart-frontend:1.0 -f Dockerfile.frontend .

#Task 5 step 5.1
sudo docker save techstart-frontend:1.0 | sudo k3s ctr images import -

#Task 6 step 6.2
kubectl delete deployment techstart-catalog techstart-frontend

#Task 6 step 6.2
kubectl delete service catalog-service catalog-external frontend-service
