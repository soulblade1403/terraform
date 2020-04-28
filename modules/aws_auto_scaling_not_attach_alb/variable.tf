####auto_scaling#####
variable "name" {}
variable "max_size" {}
variable "min_size" {}
variable "launch_configuration" {}
variable "health_check_type" {}
variable "vpc_zone_identifier" {type = "list"}
variable "enabled_metrics" {type = "list"}
#variable "count" {}
####launch_configuration####
variable "image_id" {}
variable "instance_type" {}
variable "security_groups" {}
variable "user_data" {}
variable "key_name" {}
variable "iam_instance_profile" {}
variable "launch_config_name" {}
variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch"
  type = "list"
}
variable "volume_size" {}
variable "volume_type" {}
variable "delete_on_termination" {}