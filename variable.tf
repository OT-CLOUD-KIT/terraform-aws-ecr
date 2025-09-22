##################################
# Repository Configuration
##################################

variable "repo_details" {
  description = "Map of repository names to configuration"
  type = map(object({
    repository_type           = string
    max_untagged_image_count  = optional(number)
    max_tagged_image_count    = optional(number)
    catalog_data              = optional(object({
      about_text        = optional(string)
      architectures     = optional(list(string))
      description       = optional(string)
      logo_image_blob   = optional(string)
      operating_systems = optional(list(string))
      usage_text        = optional(string)
    }))
  }))
  default = {
    "my-private-app" = {
      repository_type          = "private"
      max_untagged_image_count = 5
      max_tagged_image_count   = 10
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
}

##################################
# IAM Access Control
##################################

variable "only_pull_accounts" {
  type        = list(string)
  description = "List of account IDs allowed to pull only"
  default     = []
}

variable "push_and_pull_accounts" {
  type        = list(string)
  description = "List of account IDs allowed to push and pull"
  default     = []
}

##################################
# Repository Settings
##################################

variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "Image tag mutability setting"
}

variable "force_delete" {
  type        = bool
  default     = true
  description = "Whether to force delete the ECR repository"
}

variable "scan_on_push" {
  type        = bool
  default     = true
  description = "Enable image scanning on push"
}

variable "tag_prefix_list" {
  type        = list(string)
  default     = ["latest", "stable"]
  description = "Prefix list used in ECR lifecycle policy for tagged images"
}

variable "kms_key_arn" {
  type        = string
  default     = "arn:aws:kms:us-east-1:509633460021:key/119bd441-337d-4dfe-bc7f-ffc228833a83"
  description = "KMS key ARN for ECR encryption"
}

variable "env" {
  type = string
  default = "dev"
  
}

variable "app" {
  type = string
  default = "otcloud-kit"
}

variable "owner" {
  type = string
  default = "opstree"
}