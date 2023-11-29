resource "aws_security_group" "lb-internal" {
  name   = "internal-alb-security-group"
  vpc_id = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 8080
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

resource "aws_lb" "internal-default" {
  name            = "demo-app-internal"
  subnets         = [var.private_subnets_ids[0], var.private_subnets_ids[1]] #private subnets
  security_groups = [aws_security_group.lb-internal.id]

  tags = {
    Project = "chupito"
  }
}

resource "aws_lb_target_group" "internal-alb" {
  name = "target-group-backend"
  # port        = 80
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  #Target groups route requests to individual registered targets, 
  #such as EC2 instances, using the protocol and port number that you specify

  tags = {
    Project = "chupito"
  }

  # health_check {
  #  path = "/backend"
  # }
}

resource "aws_lb_listener" "internal_alb_listener" {
  load_balancer_arn = aws_lb.internal-default.id
  port              = "80"    #Checks for connection requests
  #Before you start using your Application Load Balancer, 
  #you must add at least one listener. If your load balancer 
  #has no listeners, it can't receive traffic from clients
  # port     = "8080"
  #The rules that you define for your listeners determine
  #how the load balancer routes requests to the targets that 
  #you register, such as EC2 instances.
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.internal-alb.id
    type             = "forward"
  }
  tags = {
    Project = "chupito"
  }
}

