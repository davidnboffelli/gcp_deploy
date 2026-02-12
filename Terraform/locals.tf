locals {

  sa_project = "host"

  prefix_projects_services = {
    "host"    = var.common_values.values.prj_host_services,
    "service" = var.common_values.values.prj_service_services,
  }

  prefix_projects_iam = [
    {
      "member"  = "user"
      "roles"   = var.common_values.values.doer_user_roles_over_prj_host,
      "project" = "host"
    },
    {
      "member"  = "user"
      "roles"   = var.common_values.values.doer_user_roles_over_prj_service,
      "project" = "service"
    },
    {
      "member"  = "serviceAccount"
      "roles"   = var.common_values.values.doer_sa_roles_over_prj_host,
      "project" = "host"
    },
    {
      "member"  = "serviceAccount"
      "roles"   = var.common_values.values.doer_sa_roles_over_prj_service,
      "project" = "service"
    }
  ]

  doers_and_values      = { for k,d in var.doers : d.name => merge({email = d.email},var.common_values.values)}

  doer_project          = merge([ for k,v in local.prefix_projects_services : { for d in var.doers : "${d.name}-${k}"=> { "doer"=d.name,"project"=k } } ]...)

  project_services      = merge([ for k,v in local.prefix_projects_services : { for pp in v : "${k}-${pp}"=> { "project"=k,"service"=pp } } ]...)
  doer_project_services = merge([ for k,v in local.project_services : { for d in var.doers : "${d.name}-${k}"=> { "doer"=d.name,"project"=v.project,"service"=v.service,"clave_prj"="${d.name}-${v.project}" } } ]...)

  doers_roles_list      = [ for t in setproduct(local.prefix_projects_iam,[ for k,v in var.doers : v ]) : merge(t...) ]
  doers_roles_map       = { for dl in local.doers_roles_list : "${dl.name}-${dl.member}-${dl.project}" => {"email"=dl.email,"name"=dl.name,"member"=dl.member,"project"=dl.project,"roles"=dl.roles} }

}