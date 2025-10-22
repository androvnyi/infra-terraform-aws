resource "aws_key_pair" "androvnyi_key" {
  key_name   = "androvnyi-key"
  public_key = file("~/.ssh/androvnyi.pub")
}



# secur group f Bastion
resource "aws_security_group" "bastion_sg" {
  name        = "${var.env}-bastion-sg"
  description = "Allow SSH access to Bastion"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] # твій IP, напр. "185.XX.XX.XX/32"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-bastion-sg"
  }
}

# Ssecur group f Private EC2
resource "aws_security_group" "private_sg" {
  name        = "${var.env}-private-sg"
  description = "Allow SSH from Bastion only"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-private-sg"
  }
}

# Bastion Instance
resource "aws_instance" "bastion" {
  ami                         = var.ami
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnet
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "${var.env}-bastion"
  }
}

# Private Instance
resource "aws_instance" "app" {
  ami                    = var.ami
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  tags = {
    Name = "${var.env}-app"
  }
}
