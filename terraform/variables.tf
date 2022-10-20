variable "ACCESS_TOKEN" {
  type        = string
  description = "a access token"
}

variable "REGION" {
  type        = string
  default     = "ams"
  description = "the region"
}

variable "APP_NAME" {
  type        = string
  description = "the name of the do app"
}

variable "APP_DOMAIN" {
  type        = string
  description = "the name of the domain"
}

variable "APP_DOMAIN_TYPE" {
  type    = string
  default = "PRIMARY"
}

variable "APP_DOMAIN_ZONE" {
  type = string
}

