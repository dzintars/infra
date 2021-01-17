variable "tld" {
  description = "Top Level Domain name e.g. 'com', 'org', 'io' without the leading dot"
  type        = string
  default     = "com"
}

variable "domain" {
  description = "Domain name e.g. 'example', 'domain', 'google', etc. without the leading dot"
  type        = string
  default     = "oswee"
}

variable "root_domain" {
  description = "Domain Name e.g. 'example.com'"
  type        = string
  default     = "oswee.com"
}

variable "subdomain" {
  description = "Name of the subdomain e.g. [subdomain].example.com"
  type        = string
  default     = "ocp"
}

variable "instance_count" {
  description = ""
  type        = number
  default     = 1
}

variable "user" {
  description = ""
  type        = string
  default     = "fedora"
}

variable "hostname" {
  description = ""
  type        = string
  default     = "bastion"
}

variable "img_url" {
  description = "cloud-init image url"
  type        = string
  default     = "https://download.fedoraproject.org/pub/fedora/linux/releases/33/cloud/x86_64/images/fedora-cloud-base-33-1.2.x86_64.qcow2"
}

variable "pool_name" {
  description = "Libvirt Pool name"
  type        = string
}

variable "img_format" {
  description = ""
  type        = string
  default     = "qcow2"
}

variable "volume_size" {
  description = "System Volume size (GB)"
  default = 10
}

variable "time_zone" {
  description = "Time Zone"
  default     = "UTC"
}

variable "network_id" {
  description = "ID of the network"
  type        = string
}

variable "network_name" {
  description = "Name of the network"
  type        = string
  default     = "default-network"
}

