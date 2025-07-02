output "vpc_id" {
  value = module.my_vpc.my_vpc_id
}

output "igw_id" {
  value = module.igw.my_igw_id
}

output "eip_id" {
  value = module.eip.eip_id
}

output "nat_id" {
  value = module.nat.nat_id
}

output "public_rt_id" {
  value = module.public_rt.rt_id
}

output "private_rt_id" {
  value = module.private_rt.rt_id
}

## Web tier
output "subnet_pub_1a_id" {
  value = module.subnet-pub-1a.subnet_id
}

output "subnet_pub_1b_id" {
  value = module.subnet-pub-1b.subnet_id
}

output "sg_alb_web_id" {
  value = module.sg_alb_web.sg_id
}

output "web_alb_arn" {
  value = module.web-alb.alb_arn
}

output "web_tier_tg_arn" {
  value = module.webTier-tg.tg_arn
}

output "web_tier_lt_id" {
  value = module.webtier_lt.lt_id
}