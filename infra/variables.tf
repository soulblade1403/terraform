#Start of AWS EC2 Instances
variable "count_instance" {
}

variable "aws_ami_id" {
}

variable "instance_type" {
}

#variable "subnet_id" {}
variable "key_name" {
}

#variable "vpc_security_group_ids" { type = "list" }
variable "iam_role" {
}

variable "user_data" {
}

variable "instance_tags" {
  type = list(string)
}

variable "volume_size" {
}

variable "volume_type" {
}

variable "delete_on_termination" {
}

variable "device_name" {
}

variable "ebs_volume_size" {
}

variable "ebs_volume_type" {
}

#End of AWS EC2 Instances

#----

#Start of VPC block
variable "vpc_cidr_block" {
}

variable "vpc_instance_tenancy" {
}

variable "vpc_enable_dns_support" {
}

variable "vpc_enable_dns_hostnames" {
}

variable "vpc_tags" {
  type = string
}

#End VPC block

#Subnet block
variable "count_subnet" {
}

variable "subnet_vpc_id_cidrblock" {
  type = list(string)
}

variable "subnet_map_public_ip_on_launch" {
}

variable "subnet_availability_zone" {
  type = list(string)
}

variable "subnet_tags" {
  type = string
}

#End Subnet block

#Internet gateway block
variable "internet_gateway_tags" {
  type = string
}

#End Internet gateway block

#Route table block
variable "route_table_tags" {
  type = string
}

#End Route table block

#Internet access block
variable "internet_access_destination_cidr_block" {
}

#End Internet access block

#Application load balancer
variable "alb_name" {
}

variable "alb_internal" {
}

variable "alb_tags" {
  type = map(string)
}

variable "alb_idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application. Default: 60"
  default     = 60
}

###########listener#################
variable "alb_port_listener" {
}

variable "protocol_listener" {
}

#variable "load_balancer_arn" {}
variable "target_group_arn" {
}

variable "alb_type" {
}

###########target-group##############
variable "target_group_name" {
}

variable "alb_target_type" {
}

variable "port_target_group" {
}

variable "protocol_target_group" {
}

variable "healthy_threshold" {
}

variable "unhealthy_threshold" {
}

variable "alb_timeout" {
}

variable "alb_interval" {
}

variable "alb_path" {
}

variable "health_port" {
}

#End Application load balancer

#provider
variable "region" {
}

#End of AWS VPC
