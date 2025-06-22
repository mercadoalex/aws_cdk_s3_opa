package policies

# This policy enforces that all S3 buckets must have the required tags: "owner" and "environment".
# It is designed to work with an array of resources as input.

# Violation if an S3 bucket is missing the "owner" tag
s3_bucket_tag_violation[msg] contains msg if
    some i
    input[i].resource.type == "aws_s3_bucket"
    input[i].resource.tags.owner == undefined
    msg := sprintf("S3 bucket missing 'owner' tag: %v", [input[i].resource])

# Violation if an S3 bucket is missing the "environment" tag
s3_bucket_tag_violation[msg] contains msg if
    some i
    input[i].resource.type == "aws_s3_bucket"
    input[i].resource.tags.environment == undefined
    msg := sprintf("S3 bucket missing 'environment' tag: %v", [input[i].resource])

# Example input structure expected by this policy:
# [
#   {
#     "resource": {
#       "type": "aws_s3_bucket",
#       "tags": {
#         "owner": "Alex",
#         "environment": "development"
#       }
#     }
#   }
# ]