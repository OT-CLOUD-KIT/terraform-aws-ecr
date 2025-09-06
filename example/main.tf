module "ecr" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-ecr.git?ref=Feature"

  only_pull_accounts     = var.only_pull_accounts
  push_and_pull_accounts = var.push_and_pull_accounts
  kms_key_arn            = var.kms_key_arn
  image_tag_mutability   = var.image_tag_mutability
  force_delete           = var.force_delete
  scan_on_push           = var.scan_on_push
  tag_prefix_list        = var.tag_prefix_list
  env = var.env
  owner = var.owner
  app = var.app

  repo_details           = var.repo_details
}
