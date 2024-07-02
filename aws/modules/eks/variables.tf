variable "name" {
  type        = string
  description = "name"
}

variable "private_subnets" {
  type        = list(string)
}

variable "vpc_id" {
  type        = string
}