variable "vpc-cidr" {
  description = "Value of the VPC Cidr Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster-name" {
  description = "Value of the Cluster Name"
  type        = string
  default     = "otel-Cluster"
}

variable "privsub-cidr" {
  description = "Value of the Private Subnets Cidr Block"
  type        = list(string)
  
}

variable "pubsub-cidr" {
  description = "Value of the Public Subnets Cidr Block"
  type        = list(string)
  
}

variable "avilability_zones" {
  description = " Avilability zones "
  type        = list(string)
}