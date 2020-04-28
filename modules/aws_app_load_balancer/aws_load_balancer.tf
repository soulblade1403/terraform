resource "aws_alb" "alb" {
  name                  = "${var.alb_name}"
  subnets               = flatten(["${var.subnet_id}"])
  security_groups       = flatten(["${var.security_groups}"])

  internal              = "${var.internal}"
  idle_timeout          = "${var.idle_timeout}"
  tags                  = "${var.tags}"
}

resource "aws_alb_listener" "alb_http" {
  load_balancer_arn     = "${var.load_balancer_arn}"
  port                  = "${var.port_listener}"
  protocol              = "${var.protocol_listener}"
  default_action {
    target_group_arn    = "${aws_alb_target_group.target_group_http.arn}"
    type                = "${var.type}"
  }
}

resource "aws_alb_target_group" "target_group_http" {
  name                  = "${var.target_group_name}"
  port                  = "${var.port_target_group}"
  protocol              = "${var.protocol_target_group}"
  vpc_id                = "${var.vpc_id}"
  target_type           = "${var.target_type}"
  health_check {
    healthy_threshold   = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    timeout             = "${var.timeout}"
    interval            = "${var.interval}"
    path                = "${var.path}"
    port                = "${var.health_port}"
  }
}
resource "aws_lb_target_group_attachment" "test"{
  count            = 2
  target_group_arn = "${aws_alb_target_group.target_group_http.arn}"
  target_id        = "${element(split(",",var.target_id),count.index)}"
  port             = "${var.port}"
}