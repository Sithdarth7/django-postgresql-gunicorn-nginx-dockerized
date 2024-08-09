variable "DEBUG" {
  type = string
  default = "0"
}
variable "SECRET_KEY" {
  type = string
  default = "change_me"
}
variable "DJANGO_ALLOWED_HOSTS" {
  type = string
  default = "localhost 127.0.0.1 [::1]"
}
variable "SQL_ENGINE" {
  type = string
  default = "django.db.backends.postgresql"
}
variable "SQL_DATABASE" {
  type = string
  default = "hello_django_prod"
}
variable "SQL_USER" {
  type = string
  default = "hello_django"
}
variable "SQL_PASSWORD" {
  type = string
  default = "hello_django"
}
variable "SQL_HOST" {
  type = string
  default = "db"
}
variable "SQL_PORT" {
  type = string
  default = "5432"
}
variable "DATABASE" {
  type = string
  default = "postgres"
}