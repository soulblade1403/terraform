variable "alb_name" {}
variable "subnet_id" {
  type = "list"
}
variable "security_groups" {
  type = "list"
}
variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application. Default: 60"
  default     = 60
}
variable "tags" {
  type = "map"
}
variable "internal" {}
###########listener#################
variable "load_balancer_arn" {}
variable "target_group_arn" {}
variable "port_listener" {}
variable "protocol_listener" {}
variable "type" {}
###########target-group##############
variable "target_group_name" {}
variable "vpc_id" {}
variable "target_type" {}
variable "port_target_group" {}
variable "protocol_target_group" {}
variable "healthy_threshold" {}
variable "unhealthy_threshold" {}
variable "timeout" {}
variable "interval" {}
variable "path" {}
variable "health_port" {}
########aws_lb_target_group_attachment#########
variable "target_id" {}
variable "port" {}