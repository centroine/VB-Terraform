########## Frontend LoadBalancer ##########
resource "aws_alb" "frontend" {
  name            = "${var.prefix}-front-alb"
  internal        = false
  security_groups = [aws_security_group.front-alb-sg.id]
  subnets         = [aws_subnet.public-subnet.0.id,aws_subnet.public-subnet.1.id]
  tags = merge(map("Name","${var.prefix}-front-alb"),var.default-tags)
}


########## Internal LoadBalancer ##########
resource "aws_alb" "internal" {
  name            = "${var.prefix}-internal-alb"
  internal        = true
  security_groups = [aws_security_group.internal-alb-sg.id]
  subnets         = [aws_subnet.private-subnet.0.id,aws_subnet.private-subnet.1.id]
  tags = merge(map("Name","${var.prefix}-internal-alb"),var.default-tags)
}