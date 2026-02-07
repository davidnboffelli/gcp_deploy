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
  parent       = "folders/414750509829"
}

resource "google_project" "doer_host_project" {
  depends_on = [ google_folder.doer_folder ]

  name       = "prj-host-dnazareno"
  project_id = "prj-host-dnazareno"
  org_id     = "577081811435"
  folder_id  = google_folder.doer_folder.id
}

resource "google_project" "doer_service_project" {
  depends_on = [ google_folder.doer_folder ]

  name       = "prj-service-dnazareno"
  project_id = "prj-service-dnazareno"
  org_id     = "577081811435"
  folder_id  = google_folder.doer_folder.id
}

resource "google_project_service" "iam_service_host_project" {
  project                     = google_project.doer_host_project.id
  service                     = "iam.googleapis.com"
  disable_dependent_services  = true
  disable_on_destroy          = false
}

resource "google_project_service" "rm_service_host_project" {
  project                     = google_project.doer_host_project.id
  service                     = "cloudresourcemanager.googleapis.com"
  disable_dependent_services  = true
  disable_on_destroy          = false
}

resource "google_project_service" "iam_service_service_project" {
  project                     = google_project.doer_service_project.id
  service                     = "iam.googleapis.com"
  disable_dependent_services  = true
  disable_on_destroy          = false
}

resource "google_project_service" "rm_service_service_project" {
  project                     = google_project.doer_service_project.id
  service                     = "cloudresourcemanager.googleapis.com"
  disable_dependent_services  = true
  disable_on_destroy          = false
}

resource "google_service_account" "doer_sa" {
  account_id   = "sa-dnazareno"
  display_name = "sa-dnazareno"
  description  = "SA para uso del Doer dnazareno en el bootcamp de GCP"
  project      = "prj-cross"
}

resource "google_folder_iam_member" "doer_user_iam" {
  depends_on = [ google_folder.doer_folder ]

  folder  = google_folder.doer_folder.id
  role    = "roles/owner"
  member  = "user:dnazareno@stemdo.io"
}

resource "google_folder_iam_member" "doer_sa_iam" {
  depends_on = [ google_folder.doer_folder ]

  folder  = google_folder.doer_folder.id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.doer_sa.email}"
}