module "naming" {
  source   = "git@github.com:OT-CLOUD-KIT/terraform-aws-naming.git?ref=dev"
  bu       = var.bu
  env      = var.env
  app      = var.app
  resource = var.resource
}

module "standard_tags" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-standard-tagging.git?ref=dev"

  bu      = var.bu
  program = var.program
  app     = var.app
  team    = var.team
  region  = var.region
  env     = var.env
}


module "ecr" {
  source = "git@github.com:OT-CLOUD-KIT/terraform-aws-ecr.git?ref=Feature"

  only_pull_accounts     = var.only_pull_accounts
  push_and_pull_accounts = var.push_and_pull_accounts
  kms_key_arn            = var.kms_key_arn
  image_tag_mutability   = var.image_tag_mutability
  force_delete           = var.force_delete
  scan_on_push           = var.scan_on_push
  tag_prefix_list        = var.tag_prefix_list
   bu                         = var.bu
  program                    = var.program
  team                       = var.team
  app                        = var.app
  env                        = var.env

  repo_details           = var.repo_details
}
