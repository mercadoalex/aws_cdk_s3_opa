package policies

# This policy enforces that all S3 buckets must have the required tags: "owner" and "environment".
# It is designed to work with an array of resources as input (as produced by your conversion script).

# Deny if an S3 bucket is missing the "owner" tag
deny[msg] {
    some i
    input[i].resource.type == "aws_s3_bucket"
    not input[i].resource.tags["owner"]
    msg := sprintf("S3 bucket missing 'owner' tag: %v", [input[i].resource])
}

# Deny if an S3 bucket is missing the "environment" tag
deny[msg] {
    some i
    input[i].resource.type == "aws_s3_bucket"
    not input[i].resource.tags["environment"]
    msg := sprintf("S3 bucket missing 'environment' tag: %v", [input[i].resource])
}

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