locals {

  prefix_projects = {
    "host"    = var.common_values.values.prj_host_services,
    "service" = var.common_values.values.prj_service_services,
  }

  sa_project = "host"

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