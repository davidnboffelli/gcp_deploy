Servicios requeridos en proyecto donde se crea service account de despliegue de recursos para poder desplegar todos los recursos:
- iam.googleapis.com
- cloudresourcemanager.googleapis.com


╷
│ Error: Conflicting configuration arguments
│ 
│   with google_project.doer_host_project,
│   on main.tf line 33, in resource "google_project" "doer_host_project":
│   33:   org_id     = "577081811435"
│ 
│ "org_id": conflicts with folder_id
╵
╷
│ Error: Conflicting configuration arguments
│ 
│   with google_project.doer_host_project,
│   on main.tf line 34, in resource "google_project" "doer_host_project":
│   34:   folder_id  = google_folder.doer_folder.id
│ 
│ "folder_id": conflicts with org_id
╵
╷
│ Error: Conflicting configuration arguments
│ 
│   with google_project.doer_service_project,
│   on main.tf line 42, in resource "google_project" "doer_service_project":
│   42:   org_id     = "577081811435"
│ 
│ "org_id": conflicts with folder_id
╵
╷
│ Error: Conflicting configuration arguments
│ 
│   with google_project.doer_service_project,
│   on main.tf line 43, in resource "google_project" "doer_service_project":
│   43:   folder_id  = google_folder.doer_folder.id
│ 
│ "folder_id": conflicts with org_id