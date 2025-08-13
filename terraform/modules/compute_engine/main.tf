# Compute instance
resource "google_compute_instance" "compute_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  labels = {
    "env"     = var.environment
    "project" = var.project
    "purpose" = var.purpose_compute_engine
  }

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
      size  = var.boot_disk_size
    }
  }

  network_interface {
    network    = "default"
    subnetwork = "fluid-compute-workers-subnet"
  }

  metadata = {
    gce-container-declaration = module.gce-container.metadata_value
    block-project-ssh-keys    = "true"
    startup-script            = var.startup_script
  }

  service_account {
    email = var.email_service_account
    scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]
  }

  lifecycle {
    prevent_destroy = true # Prevents accidental destruction
    ignore_changes = [
      metadata["ssh-keys"],
      metadata["gce-container-declaration"]
    ]
  }

}
