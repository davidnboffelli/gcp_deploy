resource "google_service_account" "doer_sa" {
  depends_on  = [ google_project_service.doer_projects ]
  for_each    = var.doers

  account_id   = "sa-${each.value.name}"
  display_name = "sa-${each.value.name}"
  description  = "SA para uso del Doer ${each.value.name} en el bootcamp de GCP"
  project      = ${local.sa_project}
}

# resource "google_organization_iam_member" "doer_organization_iam" {
#   for_each  = var.doers
#   org_id    = var.common_values.values.organization_id
#   role      = "roles/resourcemanager.organizationViewer"
#   member    = "user:${each.value.email}"
# }

# resource "google_folder_iam_member" "doer_folder_iam" {
#   for_each  = var.doers
#   folder    = var.common_values.values.bootcamp_folder_id
#   role      = "organizations/761110783262/roles/limitedBrowser"
#   member    = "user:${each.value.email}"
# }

module "doer_upper_iam" {
  source      = "git@github.com:davidnboffelli/terraform-google-iam.git//?ref=main"
  for_each    = local.doer_iam_over_folder_and_org

  roles_assignation = {
    "user:${each.value.email}" = {
      each.value.nivel == "organization" ? organization_level_roles = [
        {
          roles = each.value.roles
        }
      ],
      : 
      folder_level_roles = [
        {
          var.common_values.values.bootcamp_folder_id
          roles     = each.value.roles
        }
      ],
    }
  }
}

module "doer_project_iam" {
  depends_on  = [ google_service_account.doer_sa ]
  source      = "git@github.com:davidnboffelli/terraform-google-iam.git//?ref=main"
  for_each    = local.doers_roles_map

  roles_assignation = {
    "${each.value.member}:${each.value.member == "user" ? each.value.email : "sa-${each.value.name}@prj-${each.value.project}-${each.value.name}${local.project_suffix}.iam.gserviceaccount.com"}" = {
      project_level_roles = [
        {
          project_id  = "prj-${each.value.project}-${each.value.name}${local.project_suffix}"
          roles       = each.value.roles
        },
      ],
    }
  }
}