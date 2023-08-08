output "az" {
  value = data.aws_availability_zones.available.names
}

output "alb-sg" {
  value = module.webtier-alb-SG.alb-sg-id
}