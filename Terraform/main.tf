# module "project-factory" {
#   source  = "terraform-google-modules/project-factory/google"
#   version = "~> 18.2"

#   name                      = "prj-test-1"
#   random_project_id         = false
#   org_id                    = "577081811435"
#   folder_id                 = "414750509829"
# #   usage_bucket_name    = "pf-test-1-usage-report-bucket"
# #   usage_bucket_prefix  = "pf/test/1/integration"
#   billing_account           = "014F7F-035A51-0DB60B"
#   default_service_account   = "delete"
#   deletion_policy           = "DELETE"
# #   svpc_host_project_id = "shared_vpc_host_name"
    
# #   shared_vpc_subnets = [
# #     "projects/base-project-196723/regions/us-east1/subnetworks/default",
# #     "projects/base-project-196723/regions/us-central1/subnetworks/default",
# #     "projects/base-project-196723/regions/us-central1/subnetworks/subnet-1",
# #   ]
# }

resource "google_folder" "doer_folder" {
  display_name = "dnazareno"
  parent       = "organizations/414750509829"
}

resource "google_project" "my_project" {
  depends_on = [ google_folder.doer_folder ]

  name       = "prj-host-dnazareno"
  project_id = "prj-host-dnazareno"
  org_id     = "577081811435"
  folder_id  = google_folder.doer_folder.id
}

resource "google_project" "my_project" {
  depends_on = [ google_folder.doer_folder ]

  name       = "prj-service-dnazareno"
  project_id = "prj-service-dnazareno"
  org_id     = "577081811435"
  folder_id  = google_folder.doer_folder.id
}

resource "google_service_account" "service_accounts" {
  account_id   = "sa-dnazareno"
  display_name = "sa-dnazareno"
  description  = "SA para uso del Doer dnazareno en el bootcamp de GCP"
  project      = "prj-cross"
}

resource "google_folder_iam_member" "folder" {
  depends_on = [ google_folder.doer_folder ]

  folder  = google_folder.doer_folder.id
  role    = "roles/owner"
  member  = "user:dnazareno@stemdo.io"
}