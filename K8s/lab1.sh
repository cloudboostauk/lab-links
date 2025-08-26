#Task 4 Step 2
docker build -t 151377/mytestapp:latest  . --build-arg author=Cloudboosta

#Task 5 Step 1
docker run -d  -p 9900:9900 151377/mytestapp:latest
