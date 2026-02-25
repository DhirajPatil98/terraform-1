#VPC and security group
#key pair

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("terra-key.pub")
}

#vpc
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

#security group

resource aws_security_group my_sg {

    name = "my_security_group"
    description = "SG for VPC"
    vpc_id = aws_default_vpc.default.id
     
    ingress {

        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "SSH open"

    }
    ingress {

        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "http open"
        
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
        description = "acess open to all internet"
        
    }
}

#ec2 instnace

resource "aws_instance" "first_ec2" {
    
    key_name = aws_key_pair.deployer.key_name
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    instance_type = var.ec2_instance_type
    ami = "ami-0b6c6ebed2801a5cb"
    user_data = file("nginx.sh")

    root_block_device {
      volume_size = var.ec2_root_storage_size
      volume_type = "gp3"
    }

    tags = {

        purpose = "practice"


    }

  
}
