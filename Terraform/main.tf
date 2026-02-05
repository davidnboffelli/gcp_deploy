module "project-factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.2"

  name                      = "prj-test-1"
  random_project_id         = false
  org_id                    = "577081811435"
  folder_id                 = "414750509829"
#   usage_bucket_name    = "pf-test-1-usage-report-bucket"
#   usage_bucket_prefix  = "pf/test/1/integration"
  billing_account           = "014F7F-035A51-0DB60B"
  default_service_account   = "delete"
#   svpc_host_project_id = "shared_vpc_host_name"
    
#   shared_vpc_subnets = [
#     "projects/base-project-196723/regions/us-east1/subnetworks/default",
#     "projects/base-project-196723/regions/us-central1/subnetworks/default",
#     "projects/base-project-196723/regions/us-central1/subnetworks/subnet-1",
#   ]
}