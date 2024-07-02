variable "name" {
  type = string
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "aks_config" {
  type        = map(any)
  description = "AKS Config Object"
}