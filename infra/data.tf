data "template_file" "user-data" {
  template = file("../scripts/user_data.tpl")
  vars = {
    #    instance_tags = "${module.aws_instance.aws_instance_tags}"
    instance_tags = "module.aws_instance.aws_instance_tags"
  }
}