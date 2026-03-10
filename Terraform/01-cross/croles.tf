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
            "organizations/577081811435/roles/bootcamp.SAdoers.folder",
          ]
        }
      ]
      project_level_roles = [
        {
          project_id = "prj-host-test"
          roles = [
            "organizations/577081811435/roles/bootcamp.SAdoers.prjhost",
          ]
        }
      ]
      project_level_roles = [
        {
          project_id = "pprj-service-test-486613"
          roles = [
            "organizations/577081811435/roles/bootcamp.SAdoers.prjservice",
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
      role_id         = "bootcamp.SAdoers.folder"
      title           = "Bootcamp SA Doers Folder"
      description     = "IAM requerido por las sa de los doers sobre su carpeta para realizar los ejercicios del modulo de GCP"
    #   roles = [
    #       "roles/artifactregistry.reader",
    #       "roles/artifactregistry.writer",
    #   ],
      permissions = [
        "compute.organizations.enableXpnHost",
        "compute.organizations.enableXpnResource",
        "compute.subnetworks.setIamPolicy",
        "resourcemanager.projects.get",
        "resourcemanager.projects.list",
        "resourcemanager.projects.update",
        "compute.organizations.disableXpnResource",
        "compute.organizations.disableXpnHost",
 
        # "storage.buckets.get",
        # "storage.buckets.list",
      ],
    },
    "cr2" = {
      org_id          = "577081811435"
      role_id         = "bootcamp.SAdoers.prjhost"
      title           = "Bootcamp SA Doers Prj Host"
      description     = "IAM requerido por las sa de los doers sobre su proyecto host para realizar los ejercicios del modulo de GCP"
    #   roles = [
    #       "roles/artifactregistry.reader",
    #       "roles/artifactregistry.writer",
    #   ],
      permissions = [
      # ----------------------
      # PERMISOS DE VPC en el projecto host
      # ----------------------
        "compute.networks.create",
        "compute.networks.delete",
        "compute.networks.get",
        "compute.networks.list",
        "compute.networks.update",

      # ----------------------
      # PERMISOS DE SUBRED en el projecto host
      # ----------------------
        "compute.subnetworks.create",
        "compute.subnetworks.delete",
        "compute.subnetworks.get",
        "compute.subnetworks.list",
        "compute.subnetworks.update",

      # ----------------------
      # PERMISOS DE FIREWALL en el projecto host
      # ----------------------
        "compute.firewalls.create",
        "compute.firewalls.delete",
        "compute.firewalls.get",
        "compute.firewalls.list",
        "compute.firewalls.update",
            # "storage.buckets.get",
            # "storage.buckets.list",
      # ----------------------
      # NAT host y service
      # ----------------------
        "compute.routers.create",
        "compute.routers.get",
        "compute.routers.delete",
        "compute.routers.update",
        "compute.addresses.create",
        "compute.addresses.get"
      ],
    },
    "cr3" = {
      org_id          = "577081811435"
      role_id         = "bootcamp.SAdoers.prjservice"
      title           = "Bootcamp SA Doers Prj Service"
      description     = "IAM requerido por las sa de los doers sobre su proyecto service para realizar los ejercicios del modulo de GCP"
      roles = [
      # ----------------------
      # IAP en nel service project
      # ----------------------
        "roles/iap.tunnelResourceAccessor",
        "roles/compute.osLogin"
      ],
      permissions = [
      # ----------------------
      # PERMISOS VM en el project service
      # ----------------------
        "compute.instances.create",
        "compute.disks.create",
        "compute.networks.use",
        "compute.subnetworks.use",
        "compute.images.useReadOnly",
      # ----------------------
      # CLOUD RUN  service
      # ----------------------
        "run.services.create",
        "run.services.get",
        "run.services.update",
        "run.services.delete",
        # Necesario para leer y poder añadirle la politica de acceso de usuarios con auth
        "run.services.setIamPolicy",  
        "run.services.getIamPolicy"   
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