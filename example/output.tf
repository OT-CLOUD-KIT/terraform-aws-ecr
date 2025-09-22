
output "private_repositories" {
  description = "Private ECR repositories with name and URL"
  value       = module.ecr.private_repositories
}

output "public_repositories" {
  description = "Public ECR repositories with name and URL"
  value       = module.ecr.public_repositories
}
