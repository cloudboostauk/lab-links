for i in {1..5}; do
  curl -s http://<your-ec2-public-ip>:30080 | grep hostname
done
