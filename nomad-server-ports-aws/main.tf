terraform {
  required_version = ">= 0.11.6"
}

# https://www.nomadproject.io/guides/cluster/requirements.html#ports-used
module "nomad_client_ports_aws" {
  source = "github.com/hashicorp-modules/nomad-client-ports-aws"

  create      = "${var.create}"
  name        = "${var.name}"
  vpc_id      = "${var.vpc_id}"
  cidr_blocks = "${var.cidr_blocks}"
  tags        = "${var.tags}"
}

# The port used for the gossip protocol for cluster membership. Both TCP and
# UDP should be routable between the server nodes on this port
# https://www.nomadproject.io/docs/agent/configuration/index.html#serf-2
resource "aws_security_group_rule" "serf_tcp" {
  instance_count = "${var.create ? 1 : 0}"

  security_group_id = "${module.nomad_client_ports_aws.nomad_client_sg_id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 4648
  to_port           = 4648
  cidr_blocks       = ["${var.cidr_blocks}"]
}

# The port used for the gossip protocol for cluster membership. Both TCP and
# UDP should be routable between the server nodes on this port
# https://www.nomadproject.io/docs/agent/configuration/index.html#serf-2
resource "aws_security_group_rule" "serf_udp" {
  instance_count = "${var.create ? 1 : 0}"

  security_group_id = "${module.nomad_client_ports_aws.nomad_client_sg_id}"
  type              = "ingress"
  protocol          = "udp"
  from_port         = 4648
  to_port           = 4648
  cidr_blocks       = ["${var.cidr_blocks}"]
}
