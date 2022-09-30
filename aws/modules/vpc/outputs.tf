output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.this.id, "")
}

output "public_subnets_id" {
  value = values(aws_subnet.public)[*].id
}

output "private_subnets_id" {
  value = values(aws_subnet.private)[*].id
}
