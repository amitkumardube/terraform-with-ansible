// This is called terraform settings block
terraform {
  // to mention what terraform CLI version should process this module
  required_version = ">=0.14"
  // this blocks declares a google provider with specific version
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.58.0"
    }
  }
  // to use an experimental feature. These features are considered under experiment and can change in future releases. We need to explicitly tell Terraform if we need to use a experimental feature.
  experiments = [provider_sensitive_attrs]

  // to use a backend other than local. Local is default
  backend "gcs" {
    bucket = "tf_remote_state_amit_test"
    prefix = "terraform/state"
  }
}
