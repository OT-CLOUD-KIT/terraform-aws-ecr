output "ecr_repository_arn" {
  value       = [for i in aws_ecr_repository.ecr_new: i.arn]
  description = "Full ARN of the repository."
}

output "ecr_repository_name" {
  value       = [for i in aws_ecr_repository.ecr_new: i.name]
  description = "The name of the repository."
}

output "ecr_repository_registry_id" {
  value       = [for i in aws_ecr_repository.ecr_new: i.registry_id]
  description = "The registry ID where the repository was created."
}

output "ecr_repository_url" {
  value       = [for i in aws_ecr_repository.ecr_new: i.repository_url]
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName)"
}
