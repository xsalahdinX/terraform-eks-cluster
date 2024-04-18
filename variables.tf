variable "imgae_kind" {

  description = "number of ami"
  type        = string
  default     = "2342342523dfgdsg"

}

variable "ec2_type" {

  description = "declare ec2 typre"
  type        = map(string)
  default = {
    preprod = "t2.nano"
    prod    = "t2.micro"
  }
}

variable "my_tags" {

  description = "tags for resources"
  type        = map(string)
  default = {
    Name = "test"
    env  = "preprod"
    Id   = "^%G*YKJHJKHKJH"
  }
}


variable "env" {
  description = "control the whole infra"
  type        = string
  default     = "prod"

}

variable "ciders" {
  description = "all ciders"
  type        = map(string)
  default = {
    vpc_cider     = "10.0.0.0/16"
    public_cider  = "10.0.1.0/24"
    private_cider = "10.0.2.0/24"
  }
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