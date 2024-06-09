output "private_subnets_ids" {
  value = values(aws_subnet.private_subnets)[*].id
}