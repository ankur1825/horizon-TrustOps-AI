resource "aws_s3_bucket" "demo_policy_findings" {
  bucket = "${var.cluster_name}-policy-demo-findings"
}

resource "aws_s3_bucket_public_access_block" "demo_policy_findings" {
  bucket = aws_s3_bucket.demo_policy_findings.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_security_group" "demo_public_admin" {
  name        = "${var.cluster_name}-demo-public-admin"
  description = "Demo-only security group used to exercise IaC policy findings"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "demo_public_ssh" {
  type              = "ingress"
  description       = "Demo-only insecure SSH rule for IaC policy validation"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.demo_public_admin.id
}

resource "aws_security_group_rule" "demo_public_admin_egress" {
  type              = "egress"
  description       = "Demo-only unrestricted egress rule"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.demo_public_admin.id
}
