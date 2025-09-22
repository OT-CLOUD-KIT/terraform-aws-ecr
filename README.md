# Terraform AWS ECR Module

A Terraform module to provision **private and public AWS ECR (Elastic Container Registry) repositories** with IAM-based access control, lifecycle policies, and optional public catalog metadata.

---

## Architecture

![ecr](https://github.com/user-attachments/assets/c61b4857-f828-407d-9f6a-37c4bf76e468)

> **Note:**  
> This module supports both public and private ECR repositories, lifecycle management, KMS encryption, and cross-account access controls.

---

## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2   |
| <a name="terraform_module"></a> [Terraform](Terraform\_module) | >= 1.12.1|

---

## Features

- Supports private and public ECR repositories 

- IAM policy management for read-only and read-write access 

-  Lifecycle policies for automatic image cleanup

-  KMS encryption support

-  Catalog metadata for public ECR

- Clean, reusable structure with dynamic support for multiple repositories


## Usage

```hcl
module "ecr" {
  source = "OT-CLOUD-KIT/terraform-aws-ecr"

  repo_details = {
    my-private-app = {
      repository_type           = "private"
      max_untagged_image_count  = 10
      max_tagged_image_count    = 20
    }

    my-public-app = {
      repository_type = "public"
      catalog_data = {
        description = "Public ECR for my app"
      }
    }
  }

  only_pull_accounts      = ["111122223333"]
  push_and_pull_accounts  = ["111122223333", "444455556666"]

  image_tag_mutability    = "MUTABLE"
  scan_on_push            = true
  force_delete            = true
  kms_key_arn             = "arn:aws:kms:region:account-id:key/key-id"
  tag_prefix_list         = ["release", "prod"]
  tags = {
    Environment = "dev"
    Team        = "DevOps"
  }
}
```

## Resources

| Name                                                                                                                                          | Type     |
| --------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws\_ecr\_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)                            | resource |
| [aws\_ecr\_repository\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy)             | resource |
| [aws\_ecr\_lifecycle\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy)               | resource |
| [aws\_ecrpublic\_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecrpublic_repository)                | resource |
| [aws\_ecrpublic\_repository\_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecrpublic_repository_policy) | resource |

___

## Input


| Name                                                                                                   | Description                                       | Type           | Default     | Required |
| ------------------------------------------------------------------------------------------------------ | ------------------------------------------------- | -------------- | ----------- | :------: |
| <a name="input_repo_details"></a> [repo\_details](#input_repo_details)                                 | Map of repository name to its config              | `map(any)`     | n/a         |   yes  |
| <a name="input_only_pull_accounts"></a> [only\_pull\_accounts](#input_only_pull_accounts)              | AWS Account IDs with pull-only access             | `list(string)` | `[]`        |    no   |
| <a name="input_push_and_pull_accounts"></a> [push\_and\_pull\_accounts](#input_push_and_pull_accounts) | AWS Account IDs with push+pull access             | `list(string)` | `[]`        |    no   |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input_kms_key_arn)                                   | KMS key ARN for ECR encryption                    | `string`       | n/a         |   yes  |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input_scan_on_push)                                | Enable image scanning on push                     | `bool`         | `true`      |    no   |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input_image_tag_mutability)        | `MUTABLE` or `IMMUTABLE`                          | `string`       | `"MUTABLE"` |    no   |
| <a name="input_force_delete"></a> [force\_delete](#input_force_delete)                                 | Force delete repositories on destroy              | `bool`         | `true`      |    no   |
| <a name="input_tag_prefix_list"></a> [tag\_prefix\_list](#input_tag_prefix_list)                       | Tag prefixes for lifecycle policy (tagged images) | `list(string)` | `[]`        |    no   |
| <a name="input_tags"></a> [tags](#input_tags)                                                          | Tags to apply to all ECR resources                | `map(string)`  | `{}`        |    no   |

___

## Output

| Name                                                                                             | Description                      |
| ------------------------------------------------------------------------------------------------ | -------------------------------- |
| <a name="output_private_repositories"></a> [private\_repositories](#output_private_repositories) | Map of private repo name and URL |
| <a name="output_public_repositories"></a> [public\_repositories](#output_public_repositories)    | Map of public repo name and URI  |

___

## Contributors

- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)



- [Piyush Upadhyay](https://github.com/piiiyuushh)
- [Nikita Joshi](https://github.com/jnikita19)

