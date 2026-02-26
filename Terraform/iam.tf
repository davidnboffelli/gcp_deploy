resource "google_service_account" "doer_sa" {
  depends_on  = [ google_project_service.project_services ]
  for_each    = var.doers

  account_id   = "sa-${each.value.name}"
  display_name = "sa-${each.value.name}"
  description  = "SA para uso del Doer ${each.value.name} en el bootcamp de GCP"
  project      = "prj-${local.sa_project}-${each.value.name}${local.project_suffix}"
}

# resource "google_organization_iam_member" "organization_iam_additive" {
#   for_each = local.doers_iam_over_org

#   org_id   = var.common_values.values.organization_id
#   role     = each.value.role
#   member   = "user:${each.value.email}"
# }

# resource "google_folder_iam_member" "doers_folder_iam" {
#   for_each = local.doers_iam_over_folder

#   folder   = "folders/${google_folder.doer_folder["${each.value.name}"].folder_id}"
#   role     = each.value.role
#   member   = "user:${each.value.email}"
# }

resource "google_project_iam_member" "doers_project_iam" {
  for_each = local.doers_roles_map

  project  = "prj-${each.value.project}-${each.value.name}${local.project_suffix}"
  role     = each.value.role
  member   = "${each.value.member}:${each.value.member == "user" ? each.value.email : "sa-${each.value.name}@prj-${local.sa_project}-${each.value.name}${local.project_suffix}.iam.gserviceaccount.com"}"
}
