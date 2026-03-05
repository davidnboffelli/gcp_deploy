module "iam" {
  source = "git@github.com:davidnboffelli/terraform-google-iam.git//?ref=main"

  roles_assignation = {
    ##########################CREATED SERVICE ACCOUNTS#################################
    "user:cntenorio@stemdo.io" = {
      project_level_roles = [
        {
          project_id = "prj-host-test"
          roles = [
            "organizations/577081811435/roles/bootcamp.doers.excercises",
          ]
        }
      ]
    }
  }

  custom_roles = {
    # Ejemplo de rol personalizado con base en diferentes roles y permisos, a nivel de organización
    "cr1" = {
      org_id          = "577081811435"
      role_id         = "bootcamp.doers.excercises"
      title           = "Bootcamp Doers Excercises"
      description     = "IAM requerido por los doers para realizar los ejercicios del modulo de GCP"
    #   roles = [
    #       "roles/artifactregistry.reader",
    #       "roles/artifactregistry.writer",
    #   ],
      permissions = [
        "compute.organizations.enableXpnHost",
        "compute.subnetworks.setIamPolicy",
        # "storage.buckets.get",
        # "storage.buckets.list",
      ],
    },
    # # Ejemplo de rol personalizado con base en diferentes permisos, a nivel de proyecto
    # "cr2" = {
    #   project_id      = "prj-d-9998-ccoe-sndbx-iam-sw"
    #   role_id         = "custom.role.test2"
    #   title           = "Custom Role Test2"
    #   description     = "Rol personalizado de test2"
    #   # roles = [
    #   #     "",
    #   # ],
    #   permissions = [
    #     "storage.buckets.get",
    #     "compute.instances.list",
    #   ],
    # },
  }
}