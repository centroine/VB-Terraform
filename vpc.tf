#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

########## VPC #########
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(map("Name","${var.prefix}-vpc"),var.default-tags)
}


########## Subnets ##########
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.vpc.id
  count = var.subnet-count
  availability_zone = var.az[count.index]
  cidr_block = var.public-cidr[count.index]
  tags = merge(map("Name","${var.prefix}-${var.public-subnet-name[count.index]}"),var.default-tags)
}

resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.vpc.id
  count = var.subnet-count
  availability_zone = var.az[count.index]
  cidr_block = var.private-cidr[count.index]
  tags = merge(map("Name","${var.prefix}-${var.private-subnet-name[count.index]}"),var.default-tags)
}

resource "aws_subnet" "db-subnet" {
  vpc_id = aws_vpc.vpc.id
  count = var.subnet-count
  availability_zone = var.az[count.index]
  cidr_block = var.db-cidr[count.index]
  tags = merge(map("Name","${var.prefix}-${var.db-subnet-name[count.index]}"),var.default-tags)
}


########## Internet Gateway ##########
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(map("Name","${var.prefix}-igw"),var.default-tags)
}


########## NAT Gateway ##########
resource "aws_eip" "nat-ip" {
  vpc = true
  tags = merge(map("Name","${var.prefix}-nat-eip"),var.default-tags)
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-ip.id
  subnet_id = aws_subnet.public-subnet.0.id
  depends_on = [aws_internet_gateway.igw]
  tags = merge(map("Name","${var.prefix}-nat"),var.default-tags)
}


########## Routing Table ##########
resource "aws_default_route_table" "public-routing" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(map("Name","${var.prefix}-public-routing"),var.default-tags)
}

resource "aws_route_table" "private-routing" {
	vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
	}
	tags = merge(map("Name","${var.prefix}-private-routing"),var.default-tags)
}

resource "aws_route_table_association" "public-routing" {
  count = 2 
  subnet_id  = aws_subnet.public-subnet.*.id[count.index]
  route_table_id = aws_default_route_table.public-routing.id
}

resource "aws_route_table_association" "private-routing" {
  count = 2
  subnet_id = aws_subnet.private-subnet.*.id[count.index]
  route_table_id = aws_route_table.private-routing.id
}

resource "aws_route_table_association" "db-routing" {
  count = 2
  subnet_id = aws_subnet.db-subnet.*.id[count.index]
  route_table_id = aws_route_table.private-routing.id
}