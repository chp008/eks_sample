data "aws_vpc" "public-vpc" {
  id = var.public-vpc-id
}

data "aws_subnet_ids" "public-vpc-public-subnet-all" {
  vpc_id = data.aws_vpc.public-vpc.id
  filter {
    name   = "tag:Name"
    values = var.public-vpc-public-subnet-tags
  }
}

data "aws_subnet_ids" "public-vpc-private-subnet-all" {
  vpc_id = data.aws_vpc.public-vpc.id
  filter {
    name   = "tag:Name"
    values = var.public-vpc-private-subnet-tags
  }
}

data "aws_vpc" "private-vpc" {
  id = var.private-vpc-id
}

data "aws_subnet_ids" "private-vpc-subnet-all" {
  vpc_id = data.aws_vpc.private-vpc.id
}
