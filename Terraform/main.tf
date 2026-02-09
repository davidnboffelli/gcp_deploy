locals {

  prefix_projects = {
    "host"    = var.common_values.values.prj_host_services,
    "service" = var.common_values.values.prj_service_services,
  }

  doers_and_values = {
    for k,d in var.doers :
    d.name => merge(
      {
        email = d.email
      },
      var.common_values.values
    )
  }

  doer_project = merge([ for k,v in local.prefix_projects : { for d in var.doers : "${d.name}-${k}"=> { "doer"=d.name,"project"=k } } ]...)

  project_services = merge([ for k,v in local.prefix_projects : { for pp in v : "${k}-${pp}"=> { "project"=k,"service"=pp } } ]...)
  doer_project_services = merge([ for k,v in local.project_services : { for d in var.doers : "${d.name}-${k}"=> { "doer"=d.name,"project"=v.project,"service"=v.service,"clave_prj"="${d.name}-${v.project}" } } ]...)

}

resource "google_folder" "doer_folder" {
  for_each = local.doers_and_values

  display_name = each.key
  parent       = each.value.bootcamp_folder_id
  deletion_protection = false
}

resource "google_project" "doer_projects" {
  depends_on = [ google_folder.doer_folder ]
  for_each = local.doer_project

  name       = "prj-${each.value.project}-${each.value.doer}"
  project_id = "prj-${each.value.project}-${each.value.doer}"
  folder_id  = google_folder.doer_folder["${each.value.doer}"].id
  deletion_policy = "DELETE"
}

resource "google_project_service" "project_services" {
  for_each = local.doer_project_services

  project                     = google_project.doer_projects["${each.value.clave_prj}"].id
  service                     = each.value.service
  disable_dependent_services  = true
  disable_on_destroy          = false
}

resource "google_service_account" "doer_sa" {
  for_each = local.doers_and_values

  account_id   = "sa-${each.key}"
  display_name = "sa-${each.key}"
  description  = "SA para uso del Doer ${each.key} en el bootcamp de GCP"
  project      = each.value.prj_cross_id
}

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

# resource "google_folder" "doer_folder" {
 
#   deletion_protection = false
#   display_name = "dnazareno"
#   parent       = "folders/414750509829"
# }

# resource "google_project" "doer_host_project" {
#   depends_on = [google_folder.doer_folder]
#       deletion_policy     = "DELETE"
#       folder_id           = "206955038157"
#       name                = "prj-host-dnazareno"
#       project_id          = "prj-host-dnazareno"

# }

# resource "google_project" "doer_service_project" {
#   depends_on = [google_folder.doer_folder]
#       deletion_policy     = "DELETE"
#       folder_id           = "206955038157"
#       name                = "prj-service-dnazareno"
#       project_id          = "prj-service-dnazareno"

# }