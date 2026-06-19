resource "aws_cloudtrail" "this" {

  name           = "enterprise-cloudtrail"
  s3_bucket_name = var.s3_bucket_name

  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true

  kms_key_id = var.kms_key_id

}