
terraform {
  backend "gcs" {
    bucket = "terraform-infra-vtt-instance"
    prefix = "terraform/state/"
  }
}
