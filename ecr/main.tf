provider  "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "ecr_new" {
#  for_each = var.name
#  name     = each.key
  count   = length(var.name)
  name    = var.name[count.index]
  image_tag_mutability = var.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}
resource "aws_ecr_repository_policy" "ecr_new" {
#  for_each   = aws_ecr_repository.ecr_new
#  repository = aws_ecr_repository.ecr_new[each.key].name
  count   = length(var.name)
  repository = aws_ecr_repository.ecr_new[count.index].name
  policy = data.aws_iam_policy_document.push_and_pull.json
}
data "aws_iam_policy_document" "only_pull" {
  statement {
    sid    = "ElasticContainerRegistryOnlyPull"
    effect = "Allow"

    principals {
      identifiers = concat([local.current_account], local.only_pull_accounts)
      type        = "AWS"
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]
  }
}

# Allows specific accounts to push and pull images
data "aws_iam_policy_document" "push_and_pull" {
  # An IAM policy document to import as a base for the current policy document
  source_json = data.aws_iam_policy_document.only_pull.json

  statement {
    sid    = "ElasticContainerRegistryPushAndPull"
    effect = "Allow"

    principals {
      identifiers = concat([local.current_account], local.push_and_pull_accounts)
      type        = "AWS"
    }

    # https://docs.aws.amazon.com/AmazonECR/latest/userguide/RepositoryPolicyExamples.html#IAM_within_account
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_new" {
#  for_each   = aws_ecr_repository.ecr_new
#  repository = aws_ecr_repository.ecr_new[each.key].name
  count   = length(var.name)
  repository = aws_ecr_repository.ecr_new[count.index].name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep last ${var.max_untagged_image_count} untagged images"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = var.max_untagged_image_count
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep last ${var.max_tagged_image_count} tagged images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = var.tag_prefix_list
          countType     = "imageCountMoreThan"
          countNumber   = var.max_tagged_image_count
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
}

data "aws_caller_identity" "current" {}
