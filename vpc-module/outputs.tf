output "vpc-id" {
    description = "VPC ID"
    value = aws_vpc.main.id
  
}

output "private-subnets" {
    description = "Priv id"
    value = aws_subnet.private-subnet[*].id
  
}


output "public-subnets" {
    description = "Pub id"
    value = aws_subnet.public-subnet[*].id
  
}


