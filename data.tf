data "aws_caller_identity" "current" {}

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
  source_policy_documents = [data.aws_iam_policy_document.only_pull.json]

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
