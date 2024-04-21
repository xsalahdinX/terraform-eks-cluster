
#we can use the element function to get the value of the list based on the index
#toset() function is used to convert a list to a set insure unique values
#tolist() function is used to convert a set to a list order to access the elements by index
# % is the modulo operator, which ensures that the index stays within the bounds of the availability zones list. If the index exceeds the length of the availability zones list, it wraps around to the beginning.
locals {
  private_az_index = { for cidr in var.private_ciders : cidr => element(var.az, index(tolist(toset(var.private_ciders)), cidr) % length(var.az)) }
  public_az_index  = { for cidr in var.public_ciders : cidr => element(var.az, index(tolist(toset(var.public_ciders)), cidr) % length(var.az)) }
}