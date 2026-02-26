#!/bin/bash
echo "=========================================="
echo "     Docker Security Checklist           "
echo "=========================================="


echo ""
echo "1. DOCKER DAEMON"
echo "----------------"
docker info | grep -E "Root|Security|Storage"


echo ""
echo "2. SWARM STATUS"
echo "---------------"
docker info | grep "Swarm"


echo ""
echo "3. CONTENT TRUST"
echo "----------------"
if [ "$DOCKER_CONTENT_TRUST" == "1" ]; then
   echo "✅ Content Trust: ENABLED"
else
   echo "⚠️  Content Trust: DISABLED (enable for production)"
fi


echo ""
echo "4. RUNNING CONTAINERS"
echo "---------------------"
echo "Total: $(docker ps -q | wc -l)"


echo ""
echo "5. ROOT CONTAINERS"
echo "------------------"
for container in $(docker ps -q); do
   user=$(docker inspect $container --format='{{.Config.User}}')
   name=$(docker inspect $container --format='{{.Name}}')
   if [ -z "$user" ] || [ "$user" == "root" ] || [ "$user" == "0" ]; then
       echo "⚠️  $name running as root"
   else
       echo "✅ $name running as $user"
   fi
done


echo ""
echo "6. RESOURCE LIMITS"
echo "------------------"
for container in $(docker ps -q); do
   mem=$(docker inspect $container --format='{{.HostConfig.Memory}}')
   name=$(docker inspect $container --format='{{.Name}}')
   if [ "$mem" == "0" ]; then
       echo "⚠️  $name has NO memory limit"
   else
       echo "✅ $name memory limit: $((mem/1024/1024))MB"
   fi
done


echo ""
echo "7. PRIVILEGED CONTAINERS"
echo "------------------------"
for container in $(docker ps -q); do
   priv=$(docker inspect $container --format='{{.HostConfig.Privileged}}')
   name=$(docker inspect $container --format='{{.Name}}')
   if [ "$priv" == "true" ]; then
       echo "❌ $name is PRIVILEGED (security risk!)"
   else
       echo "✅ $name is not privileged"
   fi
done


echo ""
echo "8. SECRETS"
echo "----------"
echo "Docker secrets: $(docker secret ls -q | wc -l)"


echo ""
echo "=========================================="
echo "     Checklist Complete                  "
echo "=========================================="