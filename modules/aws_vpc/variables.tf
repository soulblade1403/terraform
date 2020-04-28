variable "vpc_cidr_block" {}
variable "vpc_instance_tenancy" {}
variable "vpc_enable_dns_support" {}
variable "vpc_enable_dns_hostnames" {}
variable "vpc_tags" {type = "string"}
#End VPC block

#Subnet block
variable "subnet_count" {}
variable "subnet_vpc_id_cidrblock" {type = "list"}
variable "subnet_map_public_ip_on_launch" {}
variable "subnet_availability_zone" {type = "list"}
variable "subnet_tags" {type = "string"}
#End Subnet block

#Internet gateway block
variable "internet_gateway_tags" {type = "string"}
#End Internet gateway block

#Route table block
variable "route_table_tags" {type = "string"}
#End Route table block

#Internet access block
variable "internet_access_destination_cidr_block" {}
#End Internet access block