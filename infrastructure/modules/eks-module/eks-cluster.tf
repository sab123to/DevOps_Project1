resource "aws_iam_role" "nodes" {
  name = "eks-project-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


resource "aws_eks_cluster" "project-eks" {
  name     = "project-eks"
  role_arn = aws_iam_role.nodes.arn

  vpc_config {
    subnet_ids = [
        aws_subnet.private-eks-subnet1.id,
        aws_subnet.private-eks-subnet2.id,
        aws_subnet.public-eks-subnet1.id,
        aws_subnet.public-eks-subnet2.id
    ]
  }

  
  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-policy
  ]
}