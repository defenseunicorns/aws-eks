variable "kubernetes_version" {
  default = "1.19"
}

variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}


variable "cluster_name" {
  type    = string
  default = ""
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "environment_tag" {
  default = "bigbang_environment"
}

variable "github_org" {
  default = ""
}