terraform {
  required_providers {
    fortiflexvm = {
      source  = "fortinetdev/fortiflexvm"
      version = "~>2.2.0"
    }
  }
}

provider "fortiflexvm" {
}