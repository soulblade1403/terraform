resource "aws_vpc" "My_VPC" {
  cidr_block           = "${var.vpc_cidr_block}"
  instance_tenancy     = "${var.vpc_instance_tenancy}"
  enable_dns_support   = "${var.vpc_enable_dns_support}"
  enable_dns_hostnames = "${var.vpc_enable_dns_hostnames}"
  tags                 = { Name = "${var.vpc_tags}"}
}
#End Create VPC

#Create subnet
resource "aws_subnet" "My_VPC_Subnet" {
  count                   = "${var.subnet_count}"
  cidr_block              = "${element(var.subnet_vpc_id_cidrblock , count.index)}"
  vpc_id                  = "${aws_vpc.My_VPC.id}"
  map_public_ip_on_launch = "${var.subnet_map_public_ip_on_launch}"
  availability_zone       = "${element (var.subnet_availability_zone, count.index)}"
tags                      = { Name = "${var.subnet_tags}" }
}
#End Create subnet

#Create Internet gateway
resource "aws_internet_gateway" "My_VPC_GW" {
  vpc_id             = "${aws_vpc.My_VPC.id}"
  tags               = { Name = "${var.internet_gateway_tags}" }
}
#End Create Internet gateway

#Create Route table
resource "aws_route_table" "My_VPC_route_table" {
  vpc_id = "${aws_vpc.My_VPC.id}"
  tags   = { Name = "${var.route_table_tags}" }
}
#End Route table

#Create Internet access
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = "${aws_route_table.My_VPC_route_table.id}"
  destination_cidr_block = "${var.internet_access_destination_cidr_block}"
  gateway_id             = "${aws_internet_gateway.My_VPC_GW.id}"
}
#End Internet access

#Associate route table with subnet
resource "aws_route_table_association" "My_VPC_associate" {
  count          = "${var.subnet_count}"
  route_table_id = "${aws_route_table.My_VPC_route_table.id}"
  subnet_id      = "${element (aws_subnet.My_VPC_Subnet.*.id, count.index)}"
}