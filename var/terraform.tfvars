#Provider
region                   = "ap-southeast-1"

#Start of VPC block
vpc_cidr_block           = "10.1.0.0/16"
vpc_instance_tenancy     = "default"
vpc_enable_dns_support   = "true"
vpc_enable_dns_hostnames = "true"
vpc_tags                 = "VPC-SOULBLADE"
#End VPC block

#Subnet block
count_subnet                   = 2
subnet_vpc_id_cidrblock        = ["10.1.3.0/24","10.1.4.0/24"]
subnet_map_public_ip_on_launch = "true"
subnet_availability_zone       = ["ap-southeast-1a","ap-southeast-1b"]
subnet_tags                    = "SUBNET-SOULBLADE"
#End Subnet block

#Internet gateway block
internet_gateway_tags = "GATEWAY-SOULBLADE"
#End Internet gateway block

#Route table block
route_table_tags = "ROUTETABLE-SOULBLADE"
#End Route table block

#Internet access block
internet_access_destination_cidr_block = "0.0.0.0/0"
#End Internet access block

#Start of EC2 Instances
count_instance = 2
aws_ami_id     = "ami-76144b0a"
instance_type  = "t2.micro"
key_name       = "secomm"
iam_role       = ""
user_data      = ""
instance_tags  = ["web1","admin"]
#root volume
volume_size           = "30"
volume_type           = "gp2"
delete_on_termination = "true"
##ebs volume
device_name     = "/dev/sdb"
ebs_volume_size = "20"
ebs_volume_type = "gp2"
#End of EC2 Instances

#Elastic Load Balancer
alb_name = "ALB-SOULBLADE"
alb_internal = "false"
alb_idle_timeout = "60"
alb_tags = {
  "Name" = "Application Load Balancer"
}
### alb_listener ###
alb_port_listener = "80"
protocol_listener = "HTTP"
#default action
target_group_arn = ""
alb_type = "forward"
### alb_target_group ###
target_group_name = "alb-target-group"
alb_target_type = "instance"
port_target_group = "8080"
protocol_target_group = "HTTP"
#Heath_check
healthy_threshold = "3"
unhealthy_threshold = "10"
alb_timeout = "20"
alb_interval = "30"
alb_path = "/"
health_port = "80"
#End Elastic Load Balancer