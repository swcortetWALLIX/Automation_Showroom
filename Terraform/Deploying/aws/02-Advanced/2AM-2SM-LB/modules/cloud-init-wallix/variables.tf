variable "to_gzip" {
  default     = false
  description = "Should the user-data be compressed ?"
  type        = bool
}

variable "to_base64_encode" {
  default     = false
  description = "Should the user-data be encoded in base64?"
  type        = bool
}

variable "set_service_user_password" {
  default     = false
  description = "Set generated passwords for the WALLIX service accounts (wabadmin, wabsuper, wabupgrade)."
  type        = bool
}

variable "use_of_lb" {
  default     = false
  description = "Configure the appliance to be served behind a load balancer."
  type        = bool
}

variable "http_host_trusted_hostnames" {
  default     = ""
  description = "FQDN of the load balancers to add to http_host_trusted_hostnames, comma separated. Required when use_of_lb is true."
  type        = string
  validation {
    condition     = (var.use_of_lb == true && var.http_host_trusted_hostnames != "") || (var.use_of_lb == false && var.http_host_trusted_hostnames == "")
    error_message = "If use_of_lb is true, please provide http_host_trusted_hostnames"
  }

}

variable "set_webui_password_and_crypto" {
  default     = false
  description = "Bastion (Session Manager) only: set a generated web UI admin password and a generated encryption passphrase."
  type        = bool
}
