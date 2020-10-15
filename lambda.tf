data "archive_file" "lambda_function_payload" {
  type        = "zip"
  output_path = "lambda_function_payload.zip"
  source {
    content  = file("api/index.js")
    filename = "index.js"
  }
}

resource "aws_lambda_function" "lambda" {
  function_name    = "lambda_Serverless"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "export.handler"
  filename         = data.archive_file.lambda_function_payload.output_path
  source_code_hash = data.archive_file.lambda_function_payload.output_base64sha256
  runtime          = "nodejs12.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.person_updates.arn
}
