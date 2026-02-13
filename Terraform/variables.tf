variable "doers" {
  type = map(object({
        name  = string
        email = string
  }))
  nullable = false
}

variable "common_values" {
  type = map(object({
        organization_id                   = optional(string,"577081811435")
        random_project_id_suffix          = optional(bool,false)
        bootcamp_folder_id                = string
        prj_host_services                 = list(string)
        prj_service_services              = list(string)
        doer_user_roles_over_org          = list(string)
        doer_user_roles_over_folder       = list(string)
        doer_user_roles_over_prj_host     = list(string)
        doer_user_roles_over_prj_service  = list(string)
        doer_sa_roles_over_prj_host       = list(string)
        doer_sa_roles_over_prj_service    = list(string)
  }))
  nullable    = false
  default     = {}
}