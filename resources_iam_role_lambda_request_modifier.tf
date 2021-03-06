/*********************************************************************\
 *
 * Lambda Function request-modifier IAM Role for this Terraform Project
 *
\*********************************************************************/

###
### IAM Assume Role Policy Document for request-modifier
###

data "aws_iam_policy_document" "request-modifier-assume-role" {
  provider = "aws.local"

  statement {
    sid = "AllowSTSAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "edgelambda.amazonaws.com",
        "lambda.amazonaws.com",
      ]
    }
  }
}

###
### IAM Role for request-modifier
###

resource "aws_iam_role" "request-modifier" {
  provider           = "aws.local"
  name               = "${local.name_short}-request-modifier"
  assume_role_policy = "${data.aws_iam_policy_document.request-modifier-assume-role.json}"
}

###
### Attach IAM Policy Object
###

resource "aws_iam_role_policy_attachment" "request-modifier" {
  provider   = "aws.local"
  role       = "${aws_iam_role.request-modifier.name}"
  policy_arn = "${aws_iam_policy.request-modifier.arn}"
}

### EOF

