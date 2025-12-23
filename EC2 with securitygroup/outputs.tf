output "instance_id" {
  value = aws_instance.ec2sg.id
}
output "public_ip" {
  value = aws_instance.ec2sg.public_ip
}
output "sg_id" {
  value = aws_security_group.awssg.id
}