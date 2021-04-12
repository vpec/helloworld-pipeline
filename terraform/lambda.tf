# Archive the code
data "archive_file" "lambda_zip" {
    type          = "zip"
    source_file   = "lambda_function_code.js"
    output_path   = "lambda_function_code.zip"
}

# Create the lambda function
resource "aws_lambda_function" "lambda_deployment_trigger" {
  filename         = "lambda_function_code.zip"
  function_name    = "lambda_deployment_trigger"
  role             = "${aws_iam_role.iam_for_lambda_tf.arn}"
  handler          = "lambda_function_code.handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "nodejs12.x"
}

# Permissions
resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}