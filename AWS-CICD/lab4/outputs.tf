output "ecr_repository_uri" {
  description = "ECR repository URI — used in CodeBuild environment variables"
  value       = aws_ecr_repository.app.repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name — used when configuring the CodePipeline deploy stage"
  value       = aws_ecs_cluster.app.name
}

output "ecs_service_name" {
  description = "ECS service name — used when configuring the CodePipeline deploy stage"
  value       = aws_ecs_service.app.name
}
