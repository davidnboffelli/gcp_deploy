terraform {
  backend "gcs" {
    bucket  = "dboffelli_tfstate_store"
    prefix  = "terraform/dboffelli"
  }
}
