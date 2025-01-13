terraform {
  required_providers {
    fortiflexvm = {
      source  = "fortinetdev/fortiflexvm"
      version = "~>2.3.4"
    }
  }
  required_version = ">= 1.0.0"
}

# Fortinet provider configuration with username and password
# provider "fortiflexvm" {
#   username = "ABCDEFG"
#   password = "HIJKLMN"
# }

# Fortinet provider configuration with environment variables
# $ export "FORTIFLEX_ACCESS_USERNAME"="ABCDEFG"
# $ export "FORTIFLEX_ACCESS_PASSWORD"="HIJKLMN"

provider "fortiflexvm" {
}