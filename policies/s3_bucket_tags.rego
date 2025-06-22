package policies

# This policy enforces that all S3 buckets must have the required tags: "owner" and "environment".

default s3_bucket_tags_allowed = false

s3_bucket_tags_allowed if
    input.resource.type == "aws_s3_bucket"
    input.resource.tags["owner"] != ""
    input.resource.tags["environment"] != ""

# Input structure expected by this policy:
# {
#   "resource": {
#     "type": "aws_s3_bucket",
#     "tags": {
#       "owner": "Alex",
#       "environment": "development"
#     }
#   }
# }