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

###############################
# Naming Convention Variables
###############################

variable "env" {
  type        = string
  description = "Environment code: d (dev), p (prod), q (qa), s (stage), g (global)"
  default     = "d"
  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of: d, p, q, s, g"
  }
}

variable "bu" {
  type        = string
  description = "Business unit name (max 10 characters)."
  default     = "BP"
  validation {
    condition     = length(var.bu) <= 10
    error_message = "Business unit name must be <= 10 characters."
  }
}

variable "app" {
  type        = string
  description = "Application name (max 10 characters)."
  default     = "db"
  validation {
    condition     = length(var.app) <= 10
    error_message = "App name must be <= 10 characters."
  }
}

variable "program" {
  type        = string
  description = "Program name (e.g., ot-cloud-kit)."
  default     = "OT"
}

variable "resource" {
  type        = string
  description = "Optional resource name (max 15 characters)."
  default     = "ECR"
  validation {
    condition     = length(var.resource) <= 20
    error_message = "Resource name must be <= 20 characters."
  }
}

variable "team" {
  type        = string
  description = "Team owner or contact email or name."
  default     = "devops"
}

###############################
# Name Generator Inputs
###############################

variable "create" {
  type        = bool
  description = "Whether to enable random suffix generation."
  default     = true
}

variable "random_alphanumeric_len" {
  type        = number
  description = "Length of random string (1 to 4 characters)"
  default     = 2
  validation {
    condition     = var.random_alphanumeric_len >= 1 && var.random_alphanumeric_len <= 4
    error_message = "Length must be between 1 and 4."
  }
}

variable "special" {
  type        = bool
  description = "Include special characters in generated names."
  default     = false
}

variable "upper" {
  type        = bool
  description = "Include uppercase characters in generated names."
  default     = false
}

variable "number" {
  type        = bool
  description = "Include numbers in generated names."
  default     = true
}

variable "gen_no_of_names" {
  type        = number
  description = "Number of names to generate using random logic."
  default     = 1
}
