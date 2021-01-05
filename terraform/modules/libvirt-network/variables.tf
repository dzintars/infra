variable "name" {
  description = "Libvirt Network name"
  type        = string
  default     = "default-network"
}

variable "cidr_range" {
  description = ""
  type        = string
  default     = "192.168.122.0/24"
}

variable "root_domain" {
  description = "Domain Name e.g. 'example.com'"
  type        = string
  default     = "oswee.com"
}

