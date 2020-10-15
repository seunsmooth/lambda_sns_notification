resource "aws_sns_topic" "person_updates" {
  name            = var.sns_topic_name
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF

  #rovisioner "local-exec" {
  #
  #   command = "sh sns_subsciption.sh"
  #   environment = {
  #   sns_arn = self.arn
  #   sns_emails = var.sns_subscription_email_address_list
  #
  #
}

# Subscribe the Lambda Function to the Topic
resource "aws_sns_topic_subscription" "person_updates_target" {
  topic_arn = aws_sns_topic.person_updates.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.lambda.arn
}


