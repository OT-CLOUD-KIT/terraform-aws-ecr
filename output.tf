
output "private_repositories" {
  description = "Map of private repository name to URL"
  value = {
    for name, repo in aws_ecr_repository.private : name => {
      name = name
      url  = repo.repository_url
    }
  }
}

output "public_repositories" {
  description = "Map of public repository name to URL"
  value = {
    for name, repo in aws_ecrpublic_repository.public : name => {
      name = name
      url  = repo.repository_uri
    }
  }
}
