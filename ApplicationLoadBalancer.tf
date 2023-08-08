module "webtier-alb-SG" {
  source = "./modules/SecurityGroup/"
  vpc_id = aws_vpc.two-tier-vpc.id
}

#creating application load balancer
resource "aws_lb" "web-tier-alb" {
  name               = "webtier-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.webtier-alb-SG.alb-sg-id]
  subnets            = [aws_subnet.subnets[0].id, aws_subnet.subnets[1].id]
}

#creating listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web-tier-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.web-tier-TG.arn
      }
    }
  }
}

# Create ALB target group
resource "aws_lb_target_group" "web-tier-TG" {
  name     = "web-tier-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.two-tier-vpc.id
  target_type = "instance"
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 40
    interval            = 50
    path                = "/"
    port                = 80
  }
}


