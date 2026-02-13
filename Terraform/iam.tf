resource "google_service_account" "doer_sa" {
  depends_on  = [ google_project_service.project_services ]
  for_each    = var.doers

  account_id   = "sa-${each.value.name}"
  display_name = "sa-${each.value.name}"
  description  = "SA para uso del Doer ${each.value.name} en el bootcamp de GCP"
  project      = "prj-${local.sa_project}-${each.value.name}${local.project_suffix}"
}

module "doer_org_iam" {
  source      = "git@github.com:davidnboffelli/terraform-google-iam.git//?ref=main"
  for_each    = local.doers_and_values

  roles_assignation = {
    "user:${each.value.email}" = {
      organization_level_roles = [
        {
          roles = var.common_values.values.doer_user_roles_over_org
        }
      ],
    }
  }
}

module "doer_folder_iam" {
  depends_on  = [ google_folder.doer_folder ]
  source      = "git@github.com:davidnboffelli/terraform-google-iam.git//?ref=main"
  for_each    = local.doers_and_values

  roles_assignation = {
    "user:${each.value.email}" = {
      folder_level_roles = [
        {
          folder_id = var.common_values.values.bootcamp_folder_id
          roles     = var.common_values.values.doer_user_roles_over_folder
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
    "${each.value.member}:${each.value.member == "user" ? each.value.email : "sa-${each.value.name}@prj-${local.sa_project}-${each.value.name}${local.project_suffix}.iam.gserviceaccount.com"}" = {
      project_level_roles = [
        {
          project_id  = "prj-${each.value.project}-${each.value.name}${local.project_suffix}"
          roles       = each.value.roles
        },
      ],
    }
  }
}