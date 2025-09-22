###############################
# ECR Access Control Variables
###############################

variable "only_pull_accounts" {
  type        = list(string)
  description = "List of AWS account IDs with pull-only access."
  default     = []
}

variable "push_and_pull_accounts" {
  type        = list(string)
  description = "List of AWS account IDs with push-and-pull access."
  default     = []
}


###############################
# ECR Configuration
###############################

variable "kms_key_arn" {
  type        = string
  description = "ARN of the KMS key for ECR encryption."
  default     = "arn:aws:kms:us-east-1:111122223333:key/example-kms-key-id"
}

variable "image_tag_mutability" {
  type        = string
  description = "Image tag mutability setting (IMMUTABLE or MUTABLE)."
  default     = "IMMUTABLE"
}

variable "force_delete" {
  type        = bool
  description = "Force delete repository even if it contains images."
  default     = true
}

variable "scan_on_push" {
  type        = bool
  description = "Enable vulnerability image scanning on push."
  default     = true
}

variable "tag_prefix_list" {
  type        = list(string)
  description = "List of tag prefixes used in lifecycle policies."
  default     = ["latest", "stable"]
}

###############################
# ECR Repository Definitions
###############################

variable "repo_details" {
  description = "Map of repositories and their configuration. Supports private and public."
  type = map(object({
    repository_type = string  # "private" or "public"

    max_untagged_image_count = optional(number)
    max_tagged_image_count   = optional(number)

    catalog_data = optional(object({
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
    },
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

variable "env" {
  type = string
  default = "dev"
  
}

variable "owner" {
  type = string
  default = "opstree"
  
}

variable "app" {
  type = string
  default = "otcloud-kit"
}