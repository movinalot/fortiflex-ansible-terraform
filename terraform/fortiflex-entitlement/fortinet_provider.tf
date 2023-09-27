terraform {
  required_providers {
    fortiflexvm = {
      source  = "fortinetdev/fortiflexvm"
      version = "~>2.0.0"
    }
  }
}

provider "fortiflexvm" {
}