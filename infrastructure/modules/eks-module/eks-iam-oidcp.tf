data "tls_certificate" "eks" {
    url = aws_eks_cluster.project-eks.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  url             = aws_eks_cluster.project-eks.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["cf23df2207d99a74fbe169e3eba035e633b65d94"]
}

