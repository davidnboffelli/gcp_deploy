doers = {
  "cntenorio" = {
    name  = "cntenorio"
    email = "cntenorio@stemdo.io"
  },
  "rgonzalez" = {
    name  = "rgonzalez"
    email = "rgonzalez@stemdo.io"
  },
}

common_values = {
  "values" = {
    bootcamp_folder_id                = "folders/414750509829"
    # random_project_id_suffix          = true
    prj_host_services                 = [
      "iam.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      ]
    prj_service_services              = [
      "iam.googleapis.com",
      "cloudresourcemanager.googleapis.com",
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