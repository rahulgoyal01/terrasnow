resource "snowflake_procedure" "proc" {
  name                 = var.procedure_name
  database             = var.database_name
  schema               = var.schema_name
  return_type          = var.return_type
  statement            = var.procedure_statement
  comment              = var.comment
  execute_as           = var.execute_as
  handler              = var.handler
  imports              = var.imports
  language             = var.language
  null_input_behavior  = var.null_input_behavior
  packages             = var.packages
  return_behavior      = var.return_behavior
  runtime_version      = var.runtime_version

  dynamic "arguments" {
    for_each = var.procedure_arguments
    content {
      name = arguments.value.name
      type = arguments.value.type
    }
  }
}

terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.83.1"
    }
  }
}