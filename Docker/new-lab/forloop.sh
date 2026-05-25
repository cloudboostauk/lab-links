# Make multiple requests
PUBLIC_IP=$(curl -s ifconfig.me)
for i in {1..10}; do
  echo "=== Request $i ==="
  curl -s --max-time 5 http://$PUBLIC_IP:8080 | head -10
  echo ""
done
