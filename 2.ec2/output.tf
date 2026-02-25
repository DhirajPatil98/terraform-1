output aws_instance_ip {

    value = aws_instance.first_ec2.public_ip
}

