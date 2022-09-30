
# Main VPC
resource "aws_vpc" "this" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "vpc-${var.environment}-${var.app_name}"
  }
}
# Internet Gateway for Public Subnets
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "gw-${var.environment}-${var.app_name}"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each = var.public_subnets_map

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["az"]
  map_public_ip_on_launch = true

  tags = {
    Name = format("public subnet in -%s-%s-%s", each.value["az"], var.environment, var.app_name)
  }
}

# Route table the public subnet traffic through the IGW
resource "aws_route_table" "public" {
  for_each = var.public_subnets_map
  vpc_id   = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table-${var.environment}-${var.app_name}"
  }
}
# Route table associations for Public subnets
resource "aws_route_table_association" "custom-rtb-public-subnet" {
  for_each = var.public_subnets_map

  route_table_id = aws_route_table.public[each.key].id
  subnet_id      = aws_subnet.public[each.key].id
}
# Private subnet


# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
resource "aws_eip" "nat_eip" {
  for_each = var.private_subnets_map

  vpc = true
}

resource "aws_nat_gateway" "nat" {
  for_each = var.private_subnets_map

  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = format("NAT for -%s-%s-%s", each.value["az"], var.environment, var.app_name)
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets_map

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["az"]

  tags = {
    Name = format("private subnet in -%s-%s-%s", each.value["az"], var.environment, var.app_name)
  }
}

# Route table for private  subnets, make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  for_each = var.private_subnets_map
  vpc_id   = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat[each.key].id
  }

  tags = {
    Name = format("private route table in -%s-%s-%s", each.value["az"], var.environment, var.app_name)
  }
}

# Route table associations for Private subnets
resource "aws_route_table_association" "custom-rtb-private-subnet" {
  for_each = var.private_subnets_map

  route_table_id = aws_route_table.private[each.key].id
  subnet_id      = aws_subnet.private[each.key].id
}

