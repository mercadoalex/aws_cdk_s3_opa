package policies

# This policy enforces that all S3 buckets must have the required tags: "owner" and "environment".

# Define the main rule for S3 bucket tagging
default allow = false

# Allow if the bucket has both required tags
allow {
    input.resource.type == "aws_s3_bucket"
    input.resource.tags["owner"] != ""
    input.resource.tags["environment"] != ""
}

# Define the input structure expected by the policy
# input.resource should contain the resource details including type and tags
# Example input structure:
# {
#   "resource": {
#     "type": "aws_s3_bucket",
#     "tags": {
#       "owner": "example-owner",
#       "environment": "production"
#     }
#   }
# }