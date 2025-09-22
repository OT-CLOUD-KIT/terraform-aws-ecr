
only_pull_accounts     = []
push_and_pull_accounts = []

kms_key_arn            = "arn:aws:kms:us-east-1:509633460021:key/119bd441-337d-4dfe-bc7f-ffc228833a83"
image_tag_mutability   = "MUTABLE"
force_delete           = true
scan_on_push           = true
tag_prefix_list        = ["latest", "stable"]



repo_details = {
  "my-private-app" = {
    repository_type           = "private"
    max_untagged_image_count  = 5
    max_tagged_image_count    = 10
  }

  "my-public-toolkit" = {
    repository_type = "public"
    catalog_data = {
      about_text        = "Toolkit for developers"
      description       = "Public repo for CLI tools"
      architectures     = ["x86_64"]
      operating_systems = ["Linux"]
      usage_text        = "Use for community projects"
    }
  }
}


env = "dev"
app = "otcloud-kit"
owner = "opstree"

