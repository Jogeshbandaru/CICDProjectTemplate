resource "aws_instance" "Nam-server" {
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    key_name = "jogesh-kp"
    vpc_security_group_ids = [aws_security_group.Nam-sg.id]
    subnet_id = aws_subnet.Nam-public-subnet-01.id
    for_each = toset(["jenkins-master", "jenkins-slave", "ansible"])
    tags = {
        Name = "${each.key}"
    }
}