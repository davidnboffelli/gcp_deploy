module "iam" {
  source = "git@github.com:davidnboffelli/terraform-google-iam.git//?ref=main"

  service_accounts = {
  }

  roles_assignation = {
    "user:cntenorio@stemdo.io" = {
      # folder_level_roles = [
      #   {
      #     folder_id = "414750509829"
      #     roles = [
      #       "roles/reader",
      #     ]
      #   }
      # ]
      project_level_roles = [
      #   {
      #     project_id = "prj-host-test"
      #     roles = [
      #       "organizations/577081811435/roles/bootcamp.userdoers.prjhost",
      #     ]
      #   },
        {
          project_id = "prj-service-test-486613"
          roles = [
            "organizations/577081811435/roles/bootcamp.userdoers.prjservice",
          ]
        },
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
        },
        {
          project_id = "prj-service-test-486613"
          roles = [
            "organizations/577081811435/roles/bootcamp.SAdoers.prjservice",
          ]
        }
      ]
      service_account_level_roles = [
        {
          sa_id = "projects/prj-service-test-486613/serviceAccounts/227433148171-compute@developer.gserviceaccount.com"
          roles = ["roles/iam.serviceAccountUser"]
        }
      ]
    }
  }

  custom_roles = {
    "bootcampSADoersFolder" = {
      org_id          = "577081811435"
      role_id         = "bootcamp.SAdoers.folder"
      title           = "Bootcamp SA Doers Folder"
      description     = "IAM requerido por las sa de los doers sobre su carpeta para realizar los ejercicios del modulo de GCP"
      permissions = [
        "compute.organizations.enableXpnHost",
        "compute.organizations.enableXpnResource",
        # "compute.subnetworks.getIamPolicy",
        # "compute.subnetworks.setIamPolicy",
        "resourcemanager.projects.get",
        "resourcemanager.projects.list",
        "resourcemanager.projects.update",
        "compute.organizations.disableXpnResource",
        "compute.organizations.disableXpnHost",
      ],
    },
    "bootcampSADoersPrjHost" = {
      org_id          = "577081811435"
      role_id         = "bootcamp.SAdoers.prjhost"
      title           = "Bootcamp SA Doers Prj Host"
      description     = "IAM requerido por las sa de los doers sobre su proyecto host para realizar los ejercicios del modulo de GCP"
      permissions = [
      # ----------------------
      # PERMISOS DE VPC en el projecto host
      # ----------------------
        "compute.networks.create",
        "compute.networks.delete",
        "compute.networks.get",
        "compute.networks.list",
        "compute.networks.update",
        "compute.networks.updatePolicy",
        "compute.projects.get",
        "compute.networks.use",
        "compute.globalOperations.get",
      # ----------------------
      # PERMISOS DE SUBRED en el projecto host
      # ----------------------
        "compute.subnetworks.create",
        "compute.subnetworks.delete",
        "compute.subnetworks.get",
        "compute.subnetworks.list",
        "compute.subnetworks.update",
        "compute.subnetworks.use",
        "compute.subnetworks.useExternalIp",
      # ----------------------
      # PERMISOS DE FIREWALL en el projecto host
      # ----------------------
        "compute.firewalls.create",
        "compute.firewalls.delete",
        "compute.firewalls.get",
        "compute.firewalls.list",
        "compute.firewalls.update",
      # ----------------------
      # NAT host y service
      # ----------------------
        "compute.routers.create",
        "compute.routers.get",
        "compute.routers.delete",
        "compute.routers.update",
        "compute.addresses.create",
        "compute.addresses.get",
        "compute.routes.create",
        "compute.routes.get",
        "compute.routes.delete"
      ],
    },
    "bootcampSADoersPrjService" = {
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
        "compute.images.useReadOnly",
        "compute.zones.get",
        "compute.instances.setMetadata",
        "compute.instances.setLabels",
        "compute.instances.delete",
        "compute.instances.setTags",
      # ----------------------
      # CLOUD RUN  service
      # ----------------------
        "run.services.create",
        "run.services.get",
        "run.services.update",
        "run.services.delete",
        # Necesario para leer y poder añadirle la politica de acceso de usuarios con auth?
        # "run.services.setIamPolicy",  
        # "run.services.getIamPolicy",
        "run.operations.get",  
      # ----------------------
      # STORAGE service
      # ----------------------
        "storage.buckets.create",
        "storage.buckets.get",
        "storage.buckets.list",
        "storage.buckets.delete",
      # ----------------------
      # Artifact Registry service
      # ----------------------
        "artifactregistry.repositories.create",
        "artifactregistry.repositories.delete",
        "artifactregistry.repositories.get",
        "artifactregistry.repositories.list",
        "artifactregistry.repositories.downloadArtifacts",
        "artifactregistry.repositories.uploadArtifacts",
        "artifactregistry.tags.create",
        "artifactregistry.tags.get",
        "artifactregistry.tags.list",
        "artifactregistry.tags.update",
      ],
    },
    "bootcampUserDoersPrjHost" = {
      org_id          = "577081811435"
      role_id         = "bootcamp.userdoers.prjhost"
      title           = "Bootcamp User Doers Prj Host"
      description     = "IAM requerido por los usuarios de los doers sobre su proyecto host para realizar los ejercicios del modulo de GCP"
      permissions = [
      # ----------------------
      # PERMISOS DE VPC en el projecto host
      # ----------------------
        "compute.networks.create",
        "compute.networks.delete",
        "compute.networks.get",
        "compute.networks.list",
        # "compute.networks.update",
        # "compute.networks.updatePolicy",
        "compute.projects.get",
        # "compute.networks.use",
        "compute.globalOperations.get",
        "compute.routes.delete",
      # ----------------------
      # PERMISOS DE SUBRED en el projecto host
      # ----------------------
        "compute.subnetworks.create",
        "compute.subnetworks.delete",
        "compute.subnetworks.get",
        "compute.subnetworks.list",
        "compute.subnetworks.update",
        # "compute.subnetworks.use",
        # "compute.subnetworks.useExternalIp",
      ]
    },
    "bootcampUserDoersPrjService" = {
      org_id          = "577081811435"
      role_id         = "bootcamp.userdoers.prjservice"
      title           = "Bootcamp User Doers Prj Service"
      description     = "IAM requerido por los usuarios de los doers sobre su proyecto service para realizar los ejercicios del modulo de GCP"
      roles = [
      # ----------------------
      # IAP en nel service project
      # ----------------------
        "roles/iap.tunnelResourceAccessor",
        "roles/compute.osLogin",
      ],
      permissions = [
      # ----------------------
      # GKE Container service
      # ----------------------
        "container.namespaces.get",
        "container.namespaces.list",
        "container.pods.create",
        "container.pods.get",
        "container.pods.list",
        "container.pods.delete",
        "container.pods.getLogs",
        "container.deployments.create",
        "container.deployments.get",
        "container.deployments.list",
        "container.deployments.update",
        "container.deployments.delete",
        "container.services.create",
        "container.services.get",
        "container.services.list",
        "container.services.update",
        "container.services.delete",
        "container.configMaps.create",
        "container.configMaps.get",
        "container.configMaps.list",
        "container.configMaps.update",
        "container.configMaps.delete",
        "container.secrets.create",
        "container.secrets.get",
        "container.secrets.list",
        "container.secrets.update",
        "container.secrets.delete",
      ]
    }
  }
}