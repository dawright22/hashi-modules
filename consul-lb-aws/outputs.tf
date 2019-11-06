output "consul_lb_sg_id" {
  value = element(concat(aws_security_group.consul_lb.*.id, [""]), 0) # TODO: Workaround for issue #11210
}

output "consul_tg_http_8500_arn" {
  value = element(concat(aws_lb_target_group.consul_http_8500.*.arn, [""]), 0) # TODO: Workaround for issue #11210
}

output "consul_tg_https_8080_arn" {
  value = element(concat(aws_lb_target_group.consul_https_8080.*.arn, [""]), 0) # TODO: Workaround for issue #11210
}

output "consul_lb_dns" {
  value = element(concat(aws_lb.consul.*.dns_name, [""]), 0) # TODO: Workaround for issue #11210
}

