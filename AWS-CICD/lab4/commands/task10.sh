aws ecr batch-delete-image \
  --repository-name quickshop \
  --region eu-west-2 \
  --image-ids "$(aws ecr list-images \
    --repository-name quickshop \
    --region eu-west-2 \
    --query 'imageIds[*]' \
    --output json)"