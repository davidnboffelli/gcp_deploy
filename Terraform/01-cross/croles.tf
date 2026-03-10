module "iam" {
  source = "git@github.com:davidnboffelli/terraform-google-iam.git//?ref=main"

  service_accounts = {
    "sa-doers-test" = {
      service_account_id = "sa-doers-test"
      project_id         = "prj-service-test-486613"
      description        = "SA de prueba para doers"
    },
  }

  roles_assignation = {
    ##########################CREATED SERVICE ACCOUNTS#################################
    "user:cntenorio@stemdo.io" = {
      project_level_roles = [
        {
          project_id = "prj-host-test"
          roles = [
            "organizations/577081811435/roles/bootcamp.SAdoers.prjhost",
          ]
        }
      ]
    }
    "serviceAccount:doers-service-account@prj-host-test.iam.gserviceaccount.com" = {
      folder_level_roles = [
        {
          folder_id = "414750509829"
          roles = [
            "organizations/577081811435/roles/bootcamp.SAdoers.folder"
          ]
        }
      ]
    }
    "newServiceAccount:sa-doers-test" = {
      folder_level_roles = [
        {
          folder_id = "414750509829"
          roles     = ["roles/compute.xpnAdmin"]
        }
      ],
    #   project_level_roles = [
    #     {
    #       project_id = "prj-host-test"
    #       roles = [
    #         "organizations/577081811435/roles/bootcamp.doers.excercises",
    #       ]
    #     },
    #     {
    #       project_id = "prj-service-test-486613"
    #       roles = [
    #         "organizations/577081811435/roles/bootcamp.doers.excercises",
    #       ]
    #     }
    #   ]
    }
  }

  custom_roles = {
    # Ejemplo de rol personalizado con base en diferentes roles y permisos, a nivel de organización
    "cr1" = {
      org_id          = "577081811435"
      role_id         = "bootcamp.SAdoers.prjhost"
      title           = "Bootcamp SA Doers Prj Host"
      description     = "IAM requerido por las sa de los doers sobre su proyecto host para realizar los ejercicios del modulo de GCP"
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
    "cr2" = {
      org_id          = "577081811435"
      role_id         = "bootcamp.SAdoers.folder"
      title           = "Bootcamp SA Doers Folder"
      description     = "IAM requerido por las sa de los doers sobre su carpeta para realizar los ejercicios del modulo de GCP"
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