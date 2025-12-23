output "vpc_id" {
  value = aws_vpc.new_vpc.id
}

output "subnet1_id" {
  value = aws_subnet.subnet1.id
}

output "subnet2_id" {
  value = aws_subnet.subnet2.id
}

output "security_group_id" {
  value = aws_security_group.sg.id
}

output "ec2_public_ips" {
  value = [aws_instance.webec21.public_ip, aws_instance.webec22.public_ip]
}

output "alb_dns" {
  value = aws_alb.alb.dns_name
}
