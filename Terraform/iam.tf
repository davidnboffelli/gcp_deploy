module "service_accounts" {
  depends_on = [ google_project.doer_projects ]
  source = "git@github.com:davidnboffelli/terraform-google-iam.git//?ref=main"
  for_each = var.doers

  service_accounts = {
    "sa-${each.value.name}" = {
      service_account_id    = "sa-${each.value.name}"
      project_id            = "prj-${local.sa_project}-${each.value.name}"
      description           = "SA para uso del Doer ${each.value.name} en el bootcamp de GCP"
    },
  }
}

