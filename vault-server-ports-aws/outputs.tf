output "vault_server_sg_id" {
  value = "${element(concat(aws_security_group.vault_server.*.id, list("")), 0)}" # TODO: Workaround for issue #11210
}
