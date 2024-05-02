resource "helm_release" "aws_auth" {
  name       = "aws-auth"
  chart      = "../charts/aws-auth"
}