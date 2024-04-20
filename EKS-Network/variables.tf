variable "vpc_cider" {
  description = "VPC CIDERS"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_ciders" {
  description = "private subnets ciders"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

}

variable "public_ciders" {
  description = "public subnets ciders"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "my_tags" {

  description = "tags for Eks resources"
  type        = map(string)
  default = {
    Name  = "EKS Resource"
    Owned = "Salahdin"
  }
}

variable "az" {
  description = "value of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]

}


variable "access_key" {
  description = " from terraform cloud"
  type        = string

}

variable "secret_key" {
  description = " from terraform cloud"
  type        = string

}

variable "region" {
  description = " from terraform cloud"
  type        = string

}