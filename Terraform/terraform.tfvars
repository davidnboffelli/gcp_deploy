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
# bootcamp_folder_id = "folders/414750509829"
# prj_host_services = {
# "iam.googleapis.com" = "iam.googleapis.com",
# "cloudresourcemanager.googleapis.com" = "cloudresourcemanager.googleapis.com"
# }
# prj_service_services = {
# "iam.googleapis.com" = "iam.googleapis.com",
# "cloudresourcemanager.googleapis.com" = "cloudresourcemanager.googleapis.com"
# }
# prj_cross_id = "prj-cross"
# roles_over_doer_user = ["roles/owner"]
# roles_over_doer_sa = ["roles/owner"]
common_values = {
  "values" = {
        prj_host_services       = ["iam.googleapis.com","cloudresourcemanager.googleapis.com"]
        prj_service_services    = ["iam.googleapis.com","cloudresourcemanager.googleapis.com"]
        prefix_projects         = [ "host","service" ]
        bootcamp_folder_id      = "folders/414750509829"
        prj_cross_id            = "prj-cross"
        roles_over_doer_user    = ["roles/owner"]
        roles_over_doer_sa      = ["roles/owner"]
  }
}