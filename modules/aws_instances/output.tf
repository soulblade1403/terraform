output "aws_instance_id" {
  value = "${join(",",aws_instance.test.*.id)}"
}
output "ip_address_public" {
  value = "${aws_instance.test.*.public_ip}"
}
output "aws_instance_private_ip" {
  value = "${aws_instance.test.*.private_ip}"
}
output "aws_instance_single_public_ip" {
  value = "${join(",",aws_instance.test.*.public_ip)}"
}
output "aws_instance_ids" {
  value = "${aws_instance.test.*.id}"
}

output "aws_instance_tags" {
  value = "${aws_instance.test.*.tags}"
}