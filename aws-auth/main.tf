resource "helm_release" "aws_auth" {
  name       = "aws-auth"
  chart      = "./charts/aws-auth"

  set {
    name   = "accountId"
    value = "${output.account_id}"
 }
  set {
    name   = "nodegroup_role_arn"
    value = "arn:aws:iam::${output.account_id}:role/node-group-role"
 }

}