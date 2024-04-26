variable "my_tags" {

  description = "tags for Eks resources"
  type        = map(string)
  default = {
    Owned = "Salahdin"
  }
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "eks_cluster"

}