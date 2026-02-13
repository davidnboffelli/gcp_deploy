doers = {
  "plopez" = {
    name  = "plopez"
    email = "plopez@stemdo.io"
  },
  "abermudez" = {
    name  = "abermudez"
    email = "abermudez@stemdo.io"
  },
}

common_values = {
  "values" = {
    bootcamp_folder_id                = "folders/414750509829"
    random_project_id_suffix          = true
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
      "organizations/761110783262/roles/limitedBrowser",
      ]     
    doer_user_roles_over_prj_host     = [
      "roles/reader",
      ]
    doer_user_roles_over_prj_service  = [
      "roles/reader",
      ]
    doer_sa_roles_over_prj_host       = [
      "roles/writer",
      ]
    doer_sa_roles_over_prj_service    = [
      "roles/writer",
      ]
  }
}