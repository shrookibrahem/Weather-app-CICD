variable "vpc-cidr-block" {
  description = "Value of the VPC Cidr Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster-name-e" {
  description = "Value of the Cluster Name"
  type        = string
  default     = "otel-Cluster"
}

variable "privsub-cidr-block" {
  description = "Value of the Private Subnets Cidr Block"
  type        = list(string)
  default = [ "10.0.1.0/24","10.0.2.0/24","10.0.3.0/24" ]
}

variable "pubsub-cidr-block" {
  description = "Value of the Public Subnets Cidr Block"
  type        = list(string)
  default = [ "10.0.4.0/24","10.0.5.0/24","10.0.6.0/24" ]
  
}

variable "avilability_zones-Name" {
  description = " Avilability zones "
  type        = list(string)
  default = [ "us-east-1a", "us-east-1b","us-east-1c" ]
}


