#Task 2 step 2.1
# Install dependencies
sudo apt-get install -y wget apt-transport-https gnupg lsb-release

# Add Trivy repository
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list


#Task 2 step 2.3

# Scan full image
trivy image python:3.9 --severity HIGH,CRITICAL | head -30

# Scan slim image
trivy image python:3.9-slim --severity HIGH,CRITICAL | head -30

# Scan Alpine image
trivy image python:3.9-alpine --severity HIGH,CRITICAL | head -30

# Fail if CRITICAL vulnerabilities found
trivy image --exit-code 1 --severity CRITICAL python:3.9-alpine

#Task 4 step 4.1
docker inspect unlimited --format='Memory: {{.HostConfig.Memory}}, CPU: {{.HostConfig.NanoCpus}}'

#Task 4 step 4.2
docker run -d --name limited \
 --memory="256m" \
 --memory-swap="256m" \
 --cpus="0.5" \
 nginx:alpine

#Task 4 step 4.6
docker service inspect sectest_web --pretty | grep -A5 Resources

#Task 5 step 5.4

docker run --rm --cap-drop=ALL nginx:alpine cat /proc/1/status | grep Cap

#Task 5 step 5.4
# Run with all capabilities dropped
docker run --rm --cap-drop=ALL --cap-add=NET_BIND_SERVICE nginx:alpine cat /proc/1/status | grep Cap


#Task 5 step 5.5
docker run -d --name readonly-test \
 --read-only \
 --tmpfs /var/cache/nginx \
 --tmpfs /var/run \
 nginx:alpine

#Task 5 step 5.5
# Run with read-only filesystem
docker exec readonly-test touch /test-file || echo "Write blocked - as expected!"


#Task 5 step 5.6
# Run with multiple security options
docker run -d --name secure-nginx \
 --user 101:101 \
 --cap-drop=ALL \
 --cap-add=NET_BIND_SERVICE \
 --read-only \
 --tmpfs /var/cache/nginx \
 --tmpfs /var/run \
 --security-opt=no-new-privileges \
 nginx:alpine

#Task 5 step 5.6
docker inspect secure-nginx --format='User: {{.Config.User}}, ReadOnly: {{.HostConfig.ReadonlyRootfs}}'

#Task 6 step 6.1
# Run container with password in environment
docker run -d --name bad-example -e DB_PASSWORD=supersecret123 nginx:alpine

# Anyone with Docker access can see it!
docker inspect bad-example --format='{{range .Config.Env}}{{println .}}{{end}}' | grep DB_PASSWORD

#Task 6 step 6.6
docker exec $(docker ps -q --filter name=secretsdemo_api) ls -la /run/secrets/

#Task 6 step 6.6
docker exec $(docker ps -q --filter name=secretsdemo_api) cat /run/secrets/db_password

#Task 6 step 6.7
docker exec $(docker ps -q --filter name=secretsdemo_api) env | grep -i password

#Task 7 step 7.3
sudo openssl x509 -in /var/lib/docker/swarm/certificates/swarm-node.crt -text -noout | grep -A2 "Validity"
