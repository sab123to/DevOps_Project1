resource "aws_iam_role" "eks-node-role" {
  name = "eks-project-role"


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "eks-nodes-policy" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks-nodes-CNI_Policy" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks-nodes-container-read_only" {
  role       = aws_iam_role.nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSContainerRegistryReadOnly"
}


resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.project-eks.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = [
    aws_subnet.private-eks-subnet1.id,
    aws_subnet.private-eks-subnet2.id
  ]
  
  capacity_type = "ON_DEMAND"
  instance_types = ["t2.micto"]
  
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

   depends_on = [
    aws_iam_role_policy_attachment.eks-nodes-policy,
    aws_iam_role_policy_attachment.eks-nodes-CNI_Policy,
    aws_iam_role_policy_attachment.eks-nodes-container-read_only,
  ]

}