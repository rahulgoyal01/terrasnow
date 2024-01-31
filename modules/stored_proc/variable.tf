variable "procedure_name" {
  type        = string
  description = "Specifies the identifier for the procedure; does not have to be unique for the schema in which the procedure is created."
}

variable "database_name" {
  type        = string
  description = "The database in which to create the procedure."
}

variable "schema_name" {
  type        = string
  description = "The schema in which to create the procedure."
}

variable "return_type" {
  type        = string
  description = "The return type of the procedure."
}

variable "procedure_statement" {
  type        = string
  description = "Specifies the code used to create the procedure."
}

variable "arguments" {
  type = list(object({
    name = string
    type = string
  }))
  description = "List of the arguments for the procedure."
  default     = null
}

variable "comment" {
  type        = string
  description = "Specifies a comment for the procedure."
  default     = null
}

variable "execute_as" {
  type        = string
  description = "Sets execute context - see caller's rights and owner's rights."
  default     = null
}

variable "handler" {
  type        = string
  description = "The handler method for Java / Python procedures."
  default     = null
}

variable "imports" {
  type        = list(string)
  description = "Imports for Java / Python procedures. For Java, this is a list of jar files, for Python, this is a list of Python files."
  default     = null
}

variable "language" {
  type        = string
  description = "Specifies the language of the stored procedure code."
}

variable "null_input_behavior" {
  type        = string
  description = "Specifies the behavior of the procedure when called with null inputs."
  default     = null
}

variable "packages" {
  type        = list(string)
  description = "List of package imports to use for Java / Python procedures."
  default     = null
}

variable "return_behavior" {
  type        = string
  description = "Specifies the behavior of the function when returning results."
  default     = null
}

variable "runtime_version" {
  type        = string
  description = "Required for Python procedures. Specifies Python runtime version."
  default     = null
}