variable "security_group_ids" {
  type        = list(string)
  description = "List of CIDR blocks for allowed IP addresses"
  default     = ["0.0.0.0/0"] # You can set your default value here if needed
}