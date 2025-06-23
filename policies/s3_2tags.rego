package policies

s3_tags_required := {msg |
    some i
    input[i].resource.type == "aws_s3_bucket"
    missing := [tag | tag := "owner"; not input[i].resource.tags.owner] ++
               [tag | tag := "environment"; not input[i].resource.tags.environment]
    count(missing) > 0
    msg := sprintf("S3 bucket missing tags %v: %v", [missing, input[i].resource])
}