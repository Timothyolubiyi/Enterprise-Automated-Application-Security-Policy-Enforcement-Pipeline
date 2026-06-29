output "instance_id" {

  value = aws_instance.wazuh.id

}

output "private_ip" {

  value = aws_instance.wazuh.private_ip

}

output "instance_arn" {

  value = aws_instance.wazuh.arn

}