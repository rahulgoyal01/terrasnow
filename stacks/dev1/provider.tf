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

# resource "snowflake_database" "db" {
#   name = "TF_DEMO"
# }

#resource "snowflake_warehouse" "warehouse" {
#  name           = "TF_DEMO"
#  warehouse_size = "large"
#  auto_suspend   = 60
#}