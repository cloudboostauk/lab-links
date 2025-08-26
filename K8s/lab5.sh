#Task 2 Step 3
 kubectl create deploy flask-app-deploy --image=ghcr.io/emmanuelogiji/cloudboosta-flask-app:0.2.0 --replicas=2 --port=9900 --dry-run=client -o yaml > deploy.yaml

#Task 3 Step 1
 kubectl set image deployment/flask-app-deploy cloudboosta-flask-app=ghcr.io/emmanuelogiji/cloudboosta-flask-app:0.3.0

#Task 5 Step 1
 kubectl rollout undo deployment/flask-app-deploy --to-revision=1

#Task 6 Step 1
 kubectl scale deployment/flask-app-deploy --replicas=4

#Task 6 Step 2
 kubectl scale deployment/flask-app-deploy --replicas=2

#Task 7 Step 1
 kubectl expose deployment flask-app-deploy --type=ClusterIP --port=80 --target-port=9900

#Task 9 Step 2
kubectl expose deployment flask-app-deploy --name=flask-app-lb --type=LoadBalancer --port=80 --target-port=9900