variable "iso_url" {
  type        = string
  description = "The URL of the ISO image to use for the installation."
}

variable "iso_checksum" {
  type        = string
  description = "The checksum of the ISO image."
}

variable "name" {
  type        = string
  description = "The name of the virtual machine."
  default     = "vm"
}

variable "domain" {
  type        = string
  description = "The domain of the virtual machine."
  default     = "localdomain"
}

variable "timezone" {
  type        = string
  description = "The timezone for the virtual machine."
  default     = "US/Eastern"
}

variable "output_directory" {
  type        = string
  description = "The directory where the built VM will be stored."
  default     = "./"
}

variable "http_directory" {
  type        = string
  description = "The directory to serve HTTP files from during the build."
  default     = "http"
}

variable "root_password" {
  type        = string
  description = "The root password for the virtual machine."
  default     = "root"
  sensitive   = true
}

variable "username" {
  type        = string
  description = "The normal user username."
  default     = "packer"
}

variable "user_password" {
  type        = string
  description = "The normal user password."
  default     = "packer"
  sensitive   = true
}
