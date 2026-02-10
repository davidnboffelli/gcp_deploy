variable "doers" {
  type = map(object({
        name  = string
        email = string
  }))
    nullable = false
}

variable "common_values" {
  type = map(object({
        prj_host_services       = list(string)
        prj_service_services    = list(string)
        organization_id         = optional(string,"577081811435")
        bootcamp_folder_id      = string
        prj_cross_id            = string
        roles_over_doer_user    = list(string)
        roles_over_doer_sa      = list(string)
  }))
  nullable    = false
  default     = {}
}

variable "git_user" {
  type      = string
  nullable  = false
}

variable "git_pat" {
  type      = string
  nullable  = false
}