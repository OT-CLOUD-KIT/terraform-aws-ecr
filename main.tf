resource "aws_ecr_repository" "ecr_new" {
  for_each             = local.repos
  name                 = each.key
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
  scan_on_push = var.scan_on_push
  }
}
resource "aws_ecr_repository_policy" "ecr_new" {
  for_each   = local.repos
  repository = aws_ecr_repository.ecr_new[each.key].name
  policy     = data.aws_iam_policy_document.push_and_pull.json
}

resource "aws_ecr_lifecycle_policy" "ecr_new" {
  for_each = local.repos
  repository = aws_ecr_repository.ecr_new[each.key].name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last ${each.value.max_untagged_image_count} untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = each.value.max_untagged_image_count
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep last ${each.value.max_tagged_image_count} tagged images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = var.tag_prefix_list
          countType     = "imageCountMoreThan"
          countNumber   = each.value.max_tagged_image_count
        }
        action = {
          type = "expire"
        }
      },
    ]
  })
}

locals {
  only_pull_accounts     = formatlist("arn:aws:iam::%s:root", var.only_pull_accounts)
  push_and_pull_accounts = formatlist("arn:aws:iam::%s:root", var.push_and_pull_accounts)
  current_account        = format("arn:aws:iam::%s:root", data.aws_caller_identity.current.account_id)
  repos = {
        for i,j in var.repo_details:
        i => {
            max_tagged_image_count = j[0]
            max_untagged_image_count = j[1]
        }
    }
}

