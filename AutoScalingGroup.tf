module "ec2-security-group" {
  source = "./modules/ec2_security_group"
  vpc_id = aws_vpc.two-tier-vpc.id
  alb-security-group = module.webtier-alb-SG.alb-sg-id

}
## Creating Launch templates
resource "aws_launch_template" "webtier-launch-template" {
  name = "webtier-launch-template"
  description = "My Web tier Launch Template"
  image_id = var.ec2_ami
  instance_type = var.instance_type
  vpc_security_group_ids = [module.ec2-security-group.ec2-sg-id]
  key_name = "ec2_key"
  user_data = filebase64("./user_data.sh")
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "asg_instances"
    }
  }

}

## Creating AutoScaling Group
resource "aws_autoscaling_group" "example" {
  launch_template {
    id      = aws_launch_template.webtier-launch-template.id
    version = "$Latest"

  }
  vpc_zone_identifier = [aws_subnet.subnets[0].id,aws_subnet.subnets[1].id]
  desired_capacity   = 2
  min_size = 2
  max_size = 3
  target_group_arns = [aws_lb_target_group.web-tier-TG.arn]
}

