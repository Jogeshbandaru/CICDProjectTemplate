# Define VPC
resource "aws_vpc" "Nam-vpc" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "Nam-vpc"
  }
}

# Define Security Group
resource "aws_security_group" "Nam-sg" {
  name = "Nam_sg"
  description = "Allow all traffic"
  vpc_id = aws_vpc.Nam-vpc.id

  ingress {
    description = "Allow all traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh-port"
  }
}

# Define Public Subnet
resource "aws_subnet" "Nam-public-subnet-01" {
  vpc_id                  = aws_vpc.Nam-vpc.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Nam-public-subnet-01"
  }
}

resource "aws_subnet" "Nam-public-subnet-02" {
  vpc_id                  = aws_vpc.Nam-vpc.id
  cidr_block              = "10.1.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Nam-public-subnet-02"
  }
}

# Define Internet Gateway
resource "aws_internet_gateway" "Nam-igw" {
  vpc_id = aws_vpc.Nam-vpc.id

  tags = {
    Name = "Nam-igw"
  }
}

# Define Route Table for Public Subnet
resource "aws_route_table" "Nam-public_rt" {
  vpc_id = aws_vpc.Nam-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Nam-igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "CICD-public_assoc" {
  subnet_id      = aws_subnet.Nam-public-subnet-01.id
  route_table_id = aws_route_table.Nam-public_rt.id
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "CICD-public1_assoc" {
  subnet_id      = aws_subnet.Nam-public-subnet-02.id
  route_table_id = aws_route_table.Nam-public_rt.id
}