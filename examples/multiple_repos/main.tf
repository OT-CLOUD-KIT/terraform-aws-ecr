provider "aws" {
  region = "ap-south-1"
}


module "ecr" {
  source          = "../../"
  repo_details    = {
   #Repo #= #[# max_tagged_image_count, #max_untagged_image_count]
    Repo1 =  [1,30]
    Repo2 =  [2,15]
    Repo3 =  [23,30]
  }
  tag_prefix_list = ["release"]
  scan_on_push    = false
  image_tag_mutability     = "IMMUTABLE"
}
