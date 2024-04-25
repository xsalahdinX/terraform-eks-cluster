variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default = "eks_cluster"
  
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
  default = "eks_node_group"
  
}

variable "subnet_ids" {
    description = "The subnet ids of the EKS cluster"
    type        = list(string)
}


variable "desired_size" {
  description = "The desired number of worker nodes"
  type        = number
  default = 2
  
}

variable "max_size" {
  description = "The maximum number of worker nodes"
  type        = number
  default = 3
  
}


variable "min_size" {
  description = "The minimum number of worker nodes"
  type        = number
  default = 1
  
}

variable "my_tags" {

  description = "tags for Eks resources"
  type        = map(string)
  default = {
    Owned = "Salahdin"
  }
}

variable "instance_type" {
  description = "The instance types of the EKS node group"
  type        = string
  default = "t3.medium"
  
}

variable "ami_type" {
  description = "The ami type of the EKS node group"
  type        = string
  default = "AL2_x86_64"
  
}