module "iam" {
  depends_on  = [ google_project.doer_projects ]
  source      = "git@github.com:davidnboffelli/terraform-google-iam.git//?ref=main"
  for_each    = local.doers_roles_map

  roles_assignation = {
    "${each.value.member}:${each.value.member == "user" ? each.value.email : "sa-${each.value.name}@prj-${each.value.project}-${each.value.name}.iam.gserviceaccount.com"}" = {
      project_level_roles = [
        {
          project_id  = "prj-${each.value.project}-${each.value.name}"
          roles       = each.value.roles
        },
      ],
    }
  }
}