variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
    default = "eks"
}
variable "cluster_version" {
    description = "The version of the EKS cluster"
    type        = string
}

variable "subnet_ids" {
    description = "The subnet ids of the EKS cluster"
    type        = list(string)
}