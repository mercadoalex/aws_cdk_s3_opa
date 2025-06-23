package policies

# This policy enforces that all AWS S3 buckets must have BOTH "environment" and "owner" tags.

s3_tags_required[msg] if
    some i
    input[i].resource.type == "aws_s3_bucket"
    (
        (input[i].resource.tags.owner == undefined
         msg := sprintf("S3 bucket missing 'owner' tag: %v", [input[i].resource]))
        or
        (input[i].resource.tags.environment == undefined
         msg := sprintf("S3 bucket missing 'environment' tag: %v", [input[i].resource]))
    )