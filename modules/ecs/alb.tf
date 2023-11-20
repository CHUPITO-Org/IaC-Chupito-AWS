resource "aws_security_group" "lb" {
  name   = "alb-security-group"
  vpc_id = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = "chupito"
  }
}

resource "aws_lb" "default" {
  name            = "alb-chupito"
  subnets         = [var.public_subnets_ids[0], var.public_subnets_ids[1]] #public subnets
  security_groups = [aws_security_group.lb.id]

  tags = {
    Project = "chupito"
  }
}

resource "aws_lb_target_group" "alb" {
  name        = "target-group-frontend"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  tags = {
    Project = "chupito"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.default.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb.id
    type             = "forward"
  }
}

