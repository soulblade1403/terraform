
#resource aws instance
variable "instance_count" {}
variable "aws_ami_id" {}
variable "instance_type" {}
variable "subnet_id" {type = "list"}
variable "key_name" {}
variable "vpc_security_group_ids" {type = "list"}
variable "iam_role" {}
variable "instance_tag" {
  type = "list"
}
variable "user_data" {}

#resource root volume
variable "volume_size" {}
variable "volume_type" {}
variable "delete_on_termination" {}

#resource ebs volume
variable "device_name" {}
variable "ebs_volume_size" {}
variable "ebs_volume_type" {}
variable "ebs_delete_on_termination" {}