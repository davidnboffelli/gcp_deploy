variable "doers" {
  type = map(object({

        name  = string
        email = string

  }))
    nullable = false
}

# variable "prj_host_services" {
#     type = map(string)
#     nullable = false
# }

# variable "prj_service_services" {
#     type = map(string)
#     nullable = false
# }

# variable "bootcamp_folder_id" {
#     type = string
#     nullable = false
# }

# # variable "organization_id" {
# #     type = string
# #     nullable = false
# # }

# variable "prj_cross_id" {
#     type = string
#     nullable = false
# }

# variable "roles_over_doer_user" {
#     type = list(string)
#     nullable = false
# }

# variable "roles_over_doer_sa" {
#     type = list(string)
#     nullable = false
# }

variable "common_values" {
  type = map(object({

    # project_level_roles = optional(
    #   list(object({
        prj_host_services       = list(string)
        prj_service_services    = list(string)
        prefix_projects         = list(string)
        organization_id         = optional(string,"577081811435")
        bootcamp_folder_id      = string
        prj_cross_id            = string
        roles_over_doer_user    = list(string)
        roles_over_doer_sa      = list(string)
    #   }))
    #   ,[]
    # )
  }))
  nullable    = false
  default     = {}
}