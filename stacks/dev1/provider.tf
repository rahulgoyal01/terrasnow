terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.83.1"
    }
  }
}

provider "snowflake" {
  profile = "snowflake-dev"
}

locals {
  workspace  = local.env[terraform.workspace]

  env = {
      snowflake_dev = {
      snowflake_profile = "snowflake-dev"
      env         = "DEV"

    }
  }
}