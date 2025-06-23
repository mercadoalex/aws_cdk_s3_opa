package policies

# This policy enforces that all AWS S3 buckets must have BOTH "environment" and "owner" tags.

s3_tags_required := {msg |
    some i
    input[i].resource.type == "aws_s3_bucket"
    missing := [t | t := tag; not input[i].resource.tags[tag]; tag := "owner"; tag := "environment"]
    msg := sprintf("S3 bucket missing tags %v: %v", [missing, input[i].resource])
    count(missing) > 0
}