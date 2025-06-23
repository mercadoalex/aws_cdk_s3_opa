package policies

# This policy enforces that all AWS S3 buckets must have the "environment" tag.

s3_bucket_environment_tag_missing = {msg |
    some i
    input[i].resource.type == "aws_s3_bucket"
    not input[i].resource.tags.environment
    msg := sprintf("S3 bucket missing 'environment' tag: %v", [input[i].resource])
}