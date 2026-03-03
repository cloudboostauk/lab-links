for i in {1..5}; do
  kubectl run test-$i --image=curlimages/curl --rm -it --restart=Never -- \
    curl -s http://catalog-service/ | grep hostname
done
