
resource "aws_key_pair" "key" {

    key_name = "my_key"
    public_key = file("terra-key4.pub")

  
}

resource "aws_default_vpc" "my_vpc" {

    tags = {
      "name" = "my default vpc"
    }


  
}

resource "aws_security_group" "my_sg" {

    vpc_id = aws_default_vpc.my_vpc.id
    name = "my_sg"


    egress {

        from_port = 0
        to_port = 0
        cidr_blocks = [ "0.0.0.0/0" ]
        protocol = "TCP"

    }

    ingress {

        from_port = 22
        to_port = 22
        cidr_blocks = [ "0.0.0.0/0" ]
        protocol = "TCP"
    }

    ingress {
        from_port = 80
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
        protocol = "TCP"
    }
  
}
resource aws_instance my_instance {
    #count = 2

    for_each = tomap({

        first_ec2= "t2.micro"
        second_ec2= "t2.medium"

    })
    key_name = aws_key_pair.key.key_name
    ami = "ami-0b6c6ebed2801a5cb"
    instance_type = each.value
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    
    depends_on = [ aws_key_pair.key, aws_security_group.my_sg ]
    
    root_block_device {
      volume_size = 15
      volume_type = "gp3"
    }

    tags = {

        Name = each.key


    }

}