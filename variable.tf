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

##################################
# Naming Convention Inputs
##################################

variable "env" {
  description = "Environment code: 'd' (dev), 'p' (prod), 'q' (qa), 's' (stage), 'g' (global)."
  type        = string
  default     = "d"

  validation {
    condition     = contains(["d", "p", "q", "s", "g"], var.env)
    error_message = "env must be one of 'd', 'p', 'q', 's', 'g'."
  }
}

variable "bu" {
  description = "Business unit name (e.g., BP, GURUKU). Max 10 characters."
  type        = string
  default     = "BP"

  validation {
    condition     = length(var.bu) <= 10
    error_message = "The business unit name must be less than or equal to 10 characters."
  }
}

variable "program" {
  description = "Name of the program (e.g., OT, BP)."
  type        = string
  default     = "OT"
}

variable "app" {
  description = "Application name (e.g., network, shared). Max 10 characters."
  type        = string
  default     = "db"

  validation {
    condition     = length(var.app) <= 10
    error_message = "The app name must be less than or equal to 10 characters."
  }
}

variable "team" {
  description = "Team responsible for the application (e.g., infra, devops)."
  type        = string
  default     = "devops"
}

variable "region" {
  description = "AWS region (e.g., us-east-1, ap-south-1)."
  type        = string
  default     = "us-east-1"
}

##################################
# Optional Name Generator Inputs
##################################

variable "create" {
  description = "Whether to create random suffix"
  type        = bool
  default     = true
}

variable "random_alphanumeric_len" {
  description = "Length of random string to append"
  type        = number
  default     = 2
}

variable "special" {
  description = "Include special characters in random string"
  type        = bool
  default     = false
}

variable "upper" {
  description = "Include uppercase letters in random string"
  type        = bool
  default     = false
}

variable "number" {
  description = "Include numbers in random string"
  type        = bool
  default     = true
}

variable "gen_no_of_names" {
  description = "Number of names to generate"
  type        = number
  default     = 1
}
