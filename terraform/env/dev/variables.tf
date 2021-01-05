variable "FQDN" {
  description = "Fully Qualified Domain Name e.g. 'example.com'"
  type = string
  default = ""
}

variable "subdomain" {
  description = "Name of the subdomain e.g. [subdomain].example.com"
  type        = string
  default     = "ocp"
}

