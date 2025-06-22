package policies

# This policy enforces that all S3 buckets must have the required tags: "owner" and "environment".
# It is designed to work with an array of resources as input (as produced by your conversion script).
# Debug output is enabled using print() statements, which will appear in stderr when running opa eval with --stderr.

# Print the entire input for debugging
_ = print("OPA DEBUG: input is", input)

# Violation if an S3 bucket is missing the "owner" tag
s3_bucket_tag_violations[msg] if
    some i
    input[i].resource.type == "aws_s3_bucket"
    input[i].resource.tags.owner == undefined
    _ = print("OPA DEBUG: owner tag missing for", input[i].resource)
    msg := sprintf("S3 bucket missing 'owner' tag: %v", [input[i].resource])

# Violation if an S3 bucket is missing the "environment" tag
s3_bucket_tag_violations[msg] if
    some i
    input[i].resource.type == "aws_s3_bucket"
    input[i].resource.tags.environment == undefined
    _ = print("OPA DEBUG: environment tag missing for", input[i].resource)
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