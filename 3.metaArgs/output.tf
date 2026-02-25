output "ec2_IP" {

    value = aws_instance.my_instance[*].public_ip
  
}