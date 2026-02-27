# Make multiple requests
for i in {1..10}; do
  curl -s http://localhost:8080 | head -5
  echo "---"
done