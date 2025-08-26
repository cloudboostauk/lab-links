#Task 1 Step 5b
kubectl run nginx --image=nginx --restart=Never --dry-run=client -o yaml > nginx.yaml 

#Task 2 Step 2
kubectl create configmap flask-config --from-literal=LOG_LEVEL=INFO

#Task 3 Step 2
kubectl create secret generic flask-secret --from-literal=AUTHOR_NAME=BIG_SECRET

#Task 4 Step 4
kubectl exec -it my-flask-app -c my-flask-app -- sh

#Task 7 Step 2
kubectl create configmap mount-config --from-file=Default.html


