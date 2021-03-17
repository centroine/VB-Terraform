########## Frontend LoadBalancer Security Group Rules ##########
resource "aws_security_group_rule" "frontend_alb_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.front-alb-sg.id
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "frontend_alb_http_test" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.front-alb-sg.id
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "frontend_alb_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.front-alb-sg.id
  lifecycle { create_before_destroy = true }
}


########## Internal LoadBalancer Security Group Rules ##########
resource "aws_security_group_rule" "internal_alb_app" {
  type              = "ingress"
  from_port         = var.app-port
  to_port           = var.app-port
  protocol          = "tcp"
  security_group_id = aws_security_group.internal-alb-sg.id
  source_security_group_id = aws_security_group.web-sg.id
  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "internal_alb_app_test" {
  type              = "ingress"
  from_port         = var.app-test-port
  to_port           = var.app-test-port
  protocol          = "tcp"
  security_group_id = aws_security_group.internal-alb-sg.id
  source_security_group_id = aws_security_group.web-sg.id
  lifecycle { create_before_destroy = true }
}


########## WEB Security Group Rules ##########
resource "aws_security_group_rule" "web-http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web-sg.id
  source_security_group_id = aws_security_group.front-alb-sg.id
  lifecycle { create_before_destroy = true }
}


########## WAS Security Group Rules ##########
resource "aws_security_group_rule" "app_http" {
  type                     = "ingress"
  from_port                = var.app-port
  to_port                  = var.app-port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.was-sg.id
  source_security_group_id = aws_security_group.internal-alb-sg.id
  lifecycle { create_before_destroy = true }
}


########## Database Security Group Rules ##########
resource "aws_security_group_rule" "db_couchbase" {
  type                     = "ingress"
  from_port                = 8091
  to_port                  = 8091
  protocol                 = "TCP"
  security_group_id        = aws_security_group.db-sg.id
  source_security_group_id = aws_security_group.was-sg.id
  lifecycle { create_before_destroy = true }
}
