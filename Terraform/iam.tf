module "iam" {
  # depends_on = [ google_project.doer_projects ]
  source = "git@github.com:davidnboffelli/terraform-google-iam.git//?ref=main"
  # for_each = local.doers_and_values

  # service_accounts = {
  #   "sa-${each.key}" = {
  #     service_account_id    = "sa-${each.key}"
  #     project_id            = "${each.value.prj_cross_id}"
  #     description           = "SA para uso del Doer ${each.key} en el bootcamp de GCP"
  #   },
  # }

  # roles_assignation = {
  #   ###############SERVICE ACCOUNTS & SERVICE AGENTS###############
  #   "newServiceAccount:sa-${each.key}" = {
  #     project_level_roles = [
  #       {
  #         project_id = "${each.value.prj_cross_id}"
  #         roles = [
  #           "roles/owner",
  #         ]
  #       },
  #     ]
  #   },
  # }

  groups = {
    "gcp-test-module-iam" = {
      name        = "gcp-test-module-iam"
      description = "Grupo de Prueba"
      type        = "default"
      members = [
        "dnazareno@stemdo.io",
      ]
    }
  }
}