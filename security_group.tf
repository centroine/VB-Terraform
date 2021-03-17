########## Frontend LoadBalancer Security Group ##########
resource "aws_security_group" "front-alb-sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "${var.prefix}-front-alb-sg"
  description = "Frontend Load Balancer Security Group"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(map("Name","${var.prefix}-front-alb-sg"),var.default-tags)
}


########## Internal LoadBalancer Security Group ##########
resource "aws_security_group" "internal-alb-sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "${var.prefix}-internal-alb-sg"
  description = "Internal Load Balancer Security Group"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(map("Name","${var.prefix}-internal-alb-sg"),var.default-tags)
}


########## WEB Security Group ##########
resource "aws_security_group" "web-sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "${var.prefix}-web-sg"
  description = "WEB Security Group"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(map("Name","${var.prefix}-web-sg"),var.default-tags) 
}


########## WAS Security Group ##########
resource "aws_security_group" "was-sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "${var.prefix}-was-sg"
  description = "WAS Security Group"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(map("Name","${var.prefix}-was-sg"),var.default-tags) 
}


########## DB Security Group ##########
resource "aws_security_group" "db-sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "${var.prefix}-db-sg"
  description = "Database Security Group"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(map("Name","${var.prefix}-db-sg"),var.default-tags) 
}