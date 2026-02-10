# resource "google_folder_iam_member" "doer_user_iam" {
#   depends_on = [ google_folder.doer_folder ]
#   for_each = local.doers_and_values

#   folder  = google_folder.doer_folder["${each.key}"].id
#   role    = each.key
#   member  = "user:dnazareno@stemdo.io"
# }

# resource "google_folder_iam_member" "doer_sa_iam" {
#   depends_on = [ google_folder.doer_folder ]
#   count = var.roles_over_doer_sa

#   folder  = google_folder.doer_folder.id
#   role    = each.key
#   member  = "serviceAccount:${google_service_account.doer_sa.email}"
# }

module "iam" {
  depends_on = [ google_project.doer_projects ]
  source              = "git::https://github.com/davidnboffelli/terraform-google-iam?ref=main"
  for_each = local.doers_and_values

  service_accounts = {
    "sa-${each.key}" = {
      service_account_id    = "sa-${each.key}"
      project_id            = "${each.value.prj_cross_id}"
      description           = "SA para uso del Doer ${each.key} en el bootcamp de GCP"
    },
  }

  roles_assignation = {
    ###############SERVICE ACCOUNTS & SERVICE AGENTS###############
    "newServiceAccount:sa-${each.key}" = {
      project_level_roles = [
        {
          project_id = "${each.value.prj_cross_id}"
          roles = [
            "roles/owner",
          ]
        },
        # {
        #   project_id = each.value.prj_cross_id
        #   roles = [
        #     "roles/bigquery.dataEditor",
        #     "organizations/577081811435/roles/projectViewer",
        #     "organizations/577081811435/roles/bucketsLister",
        #   ]
        # }
      ]
    },
  }
}