resource "aws_vpc" "main" {
  cidr_block       = var.vpc-cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.cluster-name}-vpc"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"   #Tags for Eks Aws provide it


  }
}

resource "aws_subnet" "private-subnet" {
  count = length(var.privsub-cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.privsub-cidr[count.index]
  availability_zone = var.avilability_zones[count.index]

  tags = {
    Name = "${var.cluster-name}-privatesub-${count.index}"
    "kubernetes.io/role/internal-elb" = "1"  #Tags for Eks Aws provide it
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"  #Tags for Eks Aws provide it


  }
}

resource "aws_subnet" "public-subnet" {
  count = length(var.pubsub-cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pubsub-cidr[count.index]
  availability_zone = var.avilability_zones[count.index]

  tags = {
    Name = "${var.cluster-name}-pubsub-${count.index}"
    "kubernetes.io/role/elb" = "1"  #Tags for Eks Aws provide it
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"  #Tags for Eks Aws provide it


  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.cluster-name}-GW"
  }
}

resource "aws_route_table" "PubRW" {
  count = length(var.pubsub-cidr)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  

  tags = {
    Name = "${var.cluster-name}-PubRW-${count.index}"
  }
}

resource "aws_route_table" "PrivRW" {
  count = length(var.privsub-cidr)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NATG[count.index].id
    
  }

 
  tags = {
    Name = "${var.cluster-name}-PRIVRW-${count.index}"
  }
}

resource "aws_route_table_association" "RWASS" {
  count = length(var.pubsub-cidr)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.PubRW[count.index].id

  
}

resource "aws_route_table_association" "RWASSPriv" {
  count = length(var.privsub-cidr)
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.PrivRW[count.index].id

  
}


resource "aws_eip" "lb" {
  count = length(var.pubsub-cidr)
  domain   = "vpc"
}

resource "aws_nat_gateway" "NATG" {
  count = length(var.pubsub-cidr)
  allocation_id = aws_eip.lb[count.index].id
  subnet_id     = aws_subnet.public-subnet[count.index].id

  tags = {
    Name = "${var.cluster-name}-Nat-${count.index}"
  }

 
}
