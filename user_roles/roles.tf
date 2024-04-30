
resource "aws_iam_user" "eks_user" {
  name = var.username
}

resource "aws_iam_role" "eks_access_role" {
  name               = "eks_access_role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.eks_user.arn}"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}



resource "aws_iam_policy" "eks_access_policy" {
  name        = "eks_access_policy"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Resource": "${var.cluster_arn}",
          "Action": "eks:DescribeCluster"
      }
  ]
})
}


resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.eks_access_role.name
  policy_arn = aws_iam_policy.eks_access_policy.arn
}