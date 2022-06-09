# AWS ECR Terraform Module

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage]

[opstree_homepage]: https://opstree.github.io/
[opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Amazon Elastic Container Registry (Amazon ECR) is an AWS managed container image registry service that is secure, scalable, and reliable. Amazon ECR supports private repositories with resource-based permissions using AWS IAM. This is so that specified users or Amazon EC2 instances can access your container repositories and images. You can use your preferred CLI to push, pull, and manage Docker images, Open Container Initiative (OCI) images, and OCI compatible artifacts.

This module provides you the functionality to modify your ecr as per your requirement.

**Note : For more information, you can check example folder.**

## AWS versions

AWS 4.17.1       
## Resources

| Name                                                                                                                               | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)       | Data    |
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | Data    |
| [aws_ecr_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | Resource    |
| [aws_ecr_repository_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy)              | Resource |
| [aws_ecr_lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy)              | Resource |
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                | Data Source |

## Inputs

| Name                             | Description                                                                                                                                                          | Type           | Default | Required |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ------- | :------: |
| tag_prefix_list           | List of image tag prefixes on which to take action with lifecycle policy                                                                                                                                                        | `list(string)`       |         |   Yes    |
| only_pull_accounts                         | AWS accounts which pull only.                                                                                                                                                        | `list(string)` |         |   Yes    |
| push_and_pull_accounts                     | AWS accounts which push and pull.                                                                                                                                          | `list(string)`       |         |   Yes    |
| max_untagged_image_count             | The maximum number of untagged images that you want to retain in repository.                                                                                                                                                 | `number`       |         |   Yes    |
| max_tagged_image_count                             | The maximum number of tagged images that you want to retain in repository.                                                                                                                                      | `number`       |         |   Yes    |
| scan_on_push                             | Whether images should automatically be scanned on push or not.                                                                                                                                     | `bool`  |         |   Yes    |
| image_tag_mutability                 | Whether images are allowed to overwrite existing tags.                   | `bool`  |         |   Yes    |

## Output

| Name | Description |
| ---- | ----------- |
| ecr_repository_arn | Full ARN of the repository. |
| ecr_repository_name | The name of the repository. |
| ecr_repository_registry_id | The registry ID where the repository was created. |
| ecr_repository_url | The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName). |

## Usage

```hcl
module "ecr" {
  source                = "../../"
  repo_details          = {
   #Repo #= #[# max_tagged_image_count, #max_untagged_image_count]
    Repo1 =  [1,30]
    Repo2 =  [2,15]
    Repo3 =  [23,30]
                           }
  tag_prefix_list       = ["release"]
  scan_on_push          = false
  image_tag_mutability  = "IMMUTABLE"
}
```

### Contributor

| [![Piyush Shailly][piyush_avatar]][piyush_homepage]<br/>[Piyushy Shailly][Piyush_homepage] |
| -------------------------------------------------------------------------------------------- |

[piyush_homepage]: https://media-exp1.licdn.com/dms/image/C4E03AQE_lFtqQl0ttg/profile-displayphoto-shrink_800_800/0/1600691079547?e=1660176000&v=beta&t=gdJUDhHMIF3loe6fjDwOD6QnzZwtBrHxJ_VW5VJxCeY
[piyush_avatar]: https://avatars.githubusercontent.com/u/103646446?s=400&u=40899dc6d6f2870b115a59fc13f370d274e75d16&v=4
