resource "snowflake_database" "db" {
  name                = "MYDB"
  # data_retention_days = 1
}

resource "snowflake_schema" "schema" {
  database            = snowflake_database.db.name
  name                = "MYSCHEMA"
  data_retention_days = 1
}

module "intel_sp" {
  source = "../../modules/stored_proc"

  procedure_name = "SP_INTELEX_TEST"
  database_name  = "DEV"
  schema_name    = "INTEL"
  return_type    = "VARCHAR"
  language       = "JAVASCRIPT"

  # procedure_statement = <<EOT
  #                           var X=1
  #                           return X
  #                           EOT

  procedure_statement = file("${path.module}/../../files/dev/intel_one.sql")
}

# resource "snowflake_procedure" "proc" {
#   name     = "SAMPLEPROC"
#   database = snowflake_database.db.name
#   schema   = snowflake_schema.schema.name
#   language = "JAVASCRIPT"
#   arguments {
#     name = "arg1"
#     type = "varchar"
#   }
#   arguments {
#     name = "arg2"
#     type = "DATE"
#   }
#   comment             = "Procedure with 2 arguments"
#   return_type         = "VARCHAR"
#   execute_as          = "CALLER"
#   return_behavior     = "IMMUTABLE"
#   null_input_behavior = "RETURNS NULL ON NULL INPUT"
#   statement           = <<EOT
# var X=1
# return X
# EOT
# }