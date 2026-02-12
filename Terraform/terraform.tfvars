doers = {
  "doer1" = {
    name  = "doer1"
    email = "doer1@stemdo.io"
  },
  "doer2" = {
    name  = "doer2"
    email = "doer2@stemdo.io"
  },
}

common_values = {
  "values" = {
    bootcamp_folder_id = "folders/414750509829"
    prj_host_services                 = [
      "iam.googleapis.com",
      "cloudresourcemanager.googleapis.com"
      ]
    prj_service_services              = [
      "iam.googleapis.com",
      "cloudresourcemanager.googleapis.com"
      ]
    doer_user_roles_over_prj_host     = [
      "roles/reader"
      ]
    doer_user_roles_over_prj_service  = [
      "roles/reader"
      ]
    doer_sa_roles_over_prj_host       = [
      "roles/writer"
      ]
    doer_sa_roles_over_prj_service    = [
      "roles/writer"
      ]
  }
}