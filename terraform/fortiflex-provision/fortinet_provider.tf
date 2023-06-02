terraform {
  required_providers {
    fortiflexvm = {
      source  = "fortinetdev/fortiflexvm"
      version = "1.0.0"
    }
  }
}

provider "fortiflexvm" {
}