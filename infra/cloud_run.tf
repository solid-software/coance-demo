# The API service. Plan with `terraform plan`; see
# docs/runbooks/infra-change.md before applying.
resource "google_cloud_run_v2_service" "api" {
  name     = "acme-health-api"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"

  template {
    service_account = google_service_account.api.email

    containers {
      image = var.api_image

      env {
        name  = "SESSION_IDLE_MINUTES"
        value = "10"
      }

      env {
        name = "DATABASE_URL"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.database_url.secret_id
            version = "latest"
          }
        }
      }
    }

    scaling {
      min_instance_count = 1
      max_instance_count = 10
    }
  }
}

resource "google_service_account" "api" {
  account_id   = "acme-health-api"
  display_name = "Acme Health API"
}
