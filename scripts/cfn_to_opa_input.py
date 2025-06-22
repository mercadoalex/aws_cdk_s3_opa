import sys
import yaml
import json

# Usage: python3 cfn_to_opa_input.py template.yaml opa_input.json

with open(sys.argv[1]) as f:
    template = yaml.safe_load(f)

opa_inputs = []
for res in template.get('Resources', {}).values():
    if res.get('Type') == 'AWS::S3::Bucket':
        tags = {}
        for tag in res.get('Properties', {}).get('Tags', []):
            tags[tag['Key']] = tag['Value']
        opa_inputs.append({
            "resource": {
                "type": "aws_s3_bucket",
                "tags": tags
            }
        })

with open(sys.argv[2], 'w') as f:
    json.dump(opa_inputs, f, indent=2)