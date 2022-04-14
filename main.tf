provider "aws" {
 region = "ap-south-1"
}

module "ecr" {
  source               = "./ecr"
  name                 = ["piyush", "shailly", "piyu", "sh", "pi"]
  tag_prefix_list      = ["release"]
  scan_on_push         = false
  #environment          = "ite
  #profile              = "nonprod"
  image_tag_mutability = "IMMUTABLE"
  max_untagged_image_count = 5
  max_tagged_image_count   = 30
}


