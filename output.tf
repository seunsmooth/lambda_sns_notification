#output "base_url" {
 # value = aws_api_gateway_deployment.api.invoke_url
#}
output "sns_arn" {
  value = aws_sns_topic.person_updates.arn
}

