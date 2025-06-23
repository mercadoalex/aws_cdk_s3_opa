package policies

# This policy enforces that all AWS S3 buckets must have BOTH "environment" and "owner" tags.

s3_tags_required[msg] if
    some i
    input[i].resource.type == "aws_s3_bucket"
    required := ["owner", "environment"]
    missing := [tag | tag := required[_]; not input[i].resource.tags[tag]]
    count(missing) > 0
    msg := sprintf("S3 bucket missing tags %v: %v", [missing, input[i].resource])