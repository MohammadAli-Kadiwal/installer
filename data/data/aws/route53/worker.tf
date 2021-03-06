resource "aws_route53_record" "worker_nodes_public" {
  // hack: worker_public_ips_enabled is a workaround for https://github.com/hashicorp/terraform/issues/10857
  count   = "${var.worker_public_ips_enabled ? var.worker_count : 0}"
  zone_id = "${data.aws_route53_zone.base.zone_id}"
  name    = "${var.cluster_name}-worker-${count.index}-public"
  type    = "A"
  ttl     = "60"
  records = ["${var.worker_public_ips[count.index]}"]
}
