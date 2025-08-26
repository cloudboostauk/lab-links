#Task 2 Step 1
sudo chmod 666 /var/run/docker.sock

#Task 2 Step 9
kubectl get pod etcd-minikube -n kube-system -o yaml