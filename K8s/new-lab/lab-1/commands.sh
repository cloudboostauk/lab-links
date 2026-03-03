#Task 1 step 1.3
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644

#Task 3 step 3.1
mkdir -p ~/techstart-app && cd ~/techstart-app


#Task 3 step 3.3
# Build the Docker image
sudo docker build -t techstart-catalog:1.0 .
# Import image into k3s (k3s uses containerd, not Docker)
sudo docker save techstart-catalog:1.0 | sudo k3s ctr images import -

#Task 4 step 4.3
# Forward local port to pod
kubectl port-forward pod/techstart-catalog 8080:5000 &


#Task 6 step 6.1
kubectl scale deployment techstart-catalog --replicas=5

#Task 6 step 6.3
kubectl scale deployment techstart-catalog --replicas=2
