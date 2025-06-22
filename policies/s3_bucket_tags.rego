package policies

# This policy enforces that all S3 buckets must have the required tags: "owner" and "environment".

# By default, deny unless explicitly allowed
default allow = false

# Allow if the resource is an S3 bucket and both required tags are present and non-empty
allow {
    input.resource.type == "aws_s3_bucket"
    input.resource.tags["owner"] != ""
    input.resource.tags["environment"] != ""
}

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