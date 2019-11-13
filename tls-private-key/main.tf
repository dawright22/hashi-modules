terraform {
  required_version = ">= 0.12.0"
}

resource "random_id" "name" {
  byte_length = 4
  prefix      = "${var.name}-"
}

resource "tls_private_key" "key" {
  algorithm   = "${var.algorithm}"
  rsa_bits    = "${var.rsa_bits}"
  ecdsa_curve = "${var.ecdsa_curve}"
}

resource "null_resource" "download_private_key" {
  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ${format("%s.key.pem", random_id.name.hex)} && chmod ${var.permissions} ${format("%s.key.pem", random_id.name.hex)}"
  }
}
