provider "aws" {
  version = "~> 2.0"
  region = var.region
}

#aws vpc
module "aws_vpc" {
  source = "../modules/aws_vpc"

  #VPC block
  vpc_cidr_block           = var.vpc_cidr_block
  vpc_instance_tenancy     = var.vpc_instance_tenancy
  vpc_enable_dns_support   = var.vpc_enable_dns_support
  vpc_enable_dns_hostnames = var.vpc_enable_dns_hostnames
  vpc_tags                 = var.vpc_tags

  #Subnet block
  subnet_count                   = var.count_subnet
  subnet_vpc_id_cidrblock        = var.subnet_vpc_id_cidrblock
  subnet_map_public_ip_on_launch = var.subnet_map_public_ip_on_launch
  subnet_availability_zone       = var.subnet_availability_zone
  subnet_tags                    = var.subnet_tags

  #Internet gateway block
  internet_gateway_tags = var.internet_gateway_tags

  #Route table block
  route_table_tags = var.route_table_tags

  #Internet access block
  internet_access_destination_cidr_block = var.internet_access_destination_cidr_block
}

#aws instances
module "aws_instance" {
  source                 = "../modules/aws_instances"
  instance_tag           = var.instance_tags
  instance_count         = var.count_instance
  aws_ami_id             = var.aws_ami_id
  instance_type          = var.instance_type
  subnet_id              = module.aws_vpc.aws_subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [module.sg.security_group_id]
  iam_role               = var.iam_role
  user_data              = data.template_file.user-data.rendered

  #root volume
  volume_size           = var.volume_size
  volume_type           = var.volume_type
  delete_on_termination = var.delete_on_termination

  #ebs volume
  device_name               = var.device_name
  ebs_delete_on_termination = true
  ebs_volume_size           = var.ebs_volume_size
  ebs_volume_type           = var.ebs_volume_type
}

##security group
#get ip address
data "http" "workstation_ip" {
  url = "http://icanhazip.com"
}

####
module "sg" {
  source             = "../modules/aws_sg"
  security_groupname = "sg_testing_module"
  description        = "allow traffic from sg-alb"
  environment        = "testing"
  vpc_id             = module.aws_vpc.vpc_id
  inbound_cidr_blocks = {
    "0" = ["10.1.3.0/24", "80", "80", "tcp"]
    "1" = ["10.1.4.0/24", "80", "80", "tcp"]
    "2" = ["${chomp(data.http.workstation_ip.body)}/32", "22", "22", "tcp"]
    "3" = ["0.0.0.0/0", "80", "80", "tcp"]
  }
  outbound_cidr_blocks = {
    "0" = ["0.0.0.0/0", "0", "0", "-1"]
  }

  ###source security group id###
  number_of_ingress_source_security_group_id = 0
  inbound_source_security_group              = {}
  number_of_egress_source_security_group_id  = 0
  outbound_source_security_group             = {}

  tags = {
    "Name" = "sg-test"
  }
}

module "alb" {
  source          = "../modules/aws_app_load_balancer"
  alb_name        = var.alb_name
  idle_timeout    = var.alb_idle_timeout
  internal        = var.alb_internal
  security_groups = [module.sg.security_group_id]
  subnet_id       = [module.aws_vpc.aws_subnet_id]
  tags            = var.alb_tags

  #alb_listener
  load_balancer_arn = module.alb.alb_arn
  port_listener     = var.alb_port_listener
  protocol_listener = var.protocol_listener

  #default action
  target_group_arn = ""
  type             = var.alb_type

  #alb_target_group
  port_target_group     = var.port_target_group
  protocol_target_group = var.protocol_target_group
  target_group_name     = var.target_group_name
  target_type           = var.alb_target_type
  vpc_id                = module.aws_vpc.vpc_id

  #health_check
  health_port         = var.health_port
  healthy_threshold   = var.healthy_threshold
  unhealthy_threshold = var.unhealthy_threshold
  timeout             = var.alb_timeout
  interval            = var.alb_interval
  path                = var.alb_path

  #target_group_attachment
  target_id = module.aws_instance.aws_instance_id
  port      = 80
}
