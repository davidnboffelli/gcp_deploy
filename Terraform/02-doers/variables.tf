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
        billing_account                   = optional(string,"014F7F-035A51-0DB60B")
        bootcamp_folder_id                = string
        prj_host_services                 = list(string)
        prj_service_services              = list(string)
        doer_user_roles_over_org          = list(string)
        doer_user_roles_over_folder       = list(string)
        doer_sa_roles_over_folder         = list(string)
        doer_user_roles_over_prj_host     = list(string)
        doer_user_roles_over_prj_service  = list(string)
        doer_sa_roles_over_prj_host       = list(string)
        doer_sa_roles_over_prj_service    = list(string)
  }))
  nullable    = false
  default     = {
    "values" = {
      bootcamp_folder_id                = "folders/414750509829"
      random_project_id_suffix          = true
      prj_host_services                 = [
        "compute.googleapis.com",
        "cloudresourcemanager.googleapis.com",
        "serviceusage.googleapis.com",
        "iam.googleapis.com",
        ]
      prj_service_services              = [
        "compute.googleapis.com",
        "run.googleapis.com",
        "storage.googleapis.com",
        "artifactregistry.googleapis.com",
        "container.googleapis.com",
        "iap.googleapis.com",
        "oslogin.googleapis.com",
        "cloudresourcemanager.googleapis.com",
        "serviceusage.googleapis.com",
        ]
      doer_user_roles_over_org          = [
        "roles/resourcemanager.organizationViewer",
        ]
      doer_user_roles_over_folder       = [
        "roles/reader",
        ]
      doer_sa_roles_over_folder       = [
        "organizations/577081811435/roles/bootcamp.SAdoers.folder",
        ]
      doer_user_roles_over_prj_host     = [
        "organizations/577081811435/roles/bootcamp.userdoers.prjhost",
        ]
      doer_user_roles_over_prj_service  = [
        "organizations/577081811435/roles/bootcamp.userdoers.prjservice",
        ]
      doer_sa_roles_over_prj_host       = [
        "organizations/577081811435/roles/bootcamp.SAdoers.prjhost",
        ]
      doer_sa_roles_over_prj_service    = [
        "organizations/577081811435/roles/bootcamp.SAdoers.prjservice",
        ]
    }
  }
}