##############APPLICATION LOAD BALANCER SECURITY GROUP
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

################CREATE APPLICATION LOAD BALANCER
resource "aws_lb" "default" {
  name = "example-lb"
  subnets         = [var.public_subnets_ids[0], var.public_subnets_ids[1]] #public subnets
  security_groups = [aws_security_group.lb.id]


  # count                   = length(var.public_subnets_ids) #2
  # vpc_id                  = aws_vpc.vpc_aws.id
  # cidr_block              = element(var.public_subnet_cidrs, count.index)

  tags = {
    Project = "chupito"
  }
}

resource "aws_lb_target_group" "hello_world" {
  name        = "target-group-frontend"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  tags = {
    Project = "chupito"
  }
}

resource "aws_lb_listener" "hello_world" {
  load_balancer_arn = aws_lb.default.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.hello_world.id
    type             = "forward"
  }
}

