resource "google_folder" "doer_folder" {
  for_each = local.doers_and_values

  display_name        = each.key
  parent              = each.value.bootcamp_folder_id
  deletion_protection = false
}

resource "random_id" "random_project_id_suffix" {
  byte_length = 2
}

resource "google_project" "doer_projects" {
  depends_on  = [ google_folder.doer_folder ]
  for_each    = local.doer_project

  name            = "prj-${each.value.project}-${each.value.doer}"
  project_id      = "prj-${each.value.project}-${each.value.doer}${local.project_suffix}"
  folder_id       = google_folder.doer_folder["${each.value.doer}"].id
  deletion_policy = "DELETE"
}

resource "google_project_service" "project_services" {
  depends_on  = [ google_project.doer_projects ]
  for_each    = local.doer_project_services

  project                     = google_project.doer_projects["${each.value.clave_prj}"].id
  service                     = each.value.service
  disable_dependent_services  = true
  disable_on_destroy          = false
}