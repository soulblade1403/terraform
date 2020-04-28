output "launch_configuration_name" {
  value = "${aws_launch_configuration.launch_config.name}"
}
output "auto_scaling_name" {
  value = "${aws_autoscaling_group.auto_scaling_group.name}"
}
output "asg_arn" {
  value = "${aws_autoscaling_group.auto_scaling_group.arn}"
}