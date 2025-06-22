# AWS CDK S3 OPA Example

This project demonstrates how to use the AWS Cloud Development Kit (CDK) in TypeScript to provision S3 buckets **with mandatory tags** and enforce tagging policies using [Open Policy Agent (OPA)](https://www.openpolicyagent.org/) in a CI/CD workflow.

## Project Structure

```
aws_cdk_s3_opa/
├── bin/                      # CDK app entry point
├── lib/                      # CDK stack definitions
├── policies/                 # OPA .rego policies
├── .github/
│   └── workflows/            # GitHub Actions workflow for OPA policy enforcement
│   └── scripts/              # Helper scripts for policy input conversion
├── cdk.json                  # CDK configuration
├── package.json              # Node.js dependencies and scripts
├── tsconfig.json             # TypeScript configuration
└── README.md                 # Project documentation
```

## What This Project Does

- **Creates two S3 buckets** using AWS CDK, each with unique names and required tags (`owner` and `environment`).
- **Defines OPA policies** (in `policies/`) to enforce that all S3 buckets have the required tags.
- **Includes a GitHub Actions workflow** that:
  - Synthesizes the CDK stack to a CloudFormation template.
  - Converts the template to OPA input.
  - Runs all OPA policies in the `policies/` folder.
  - **Fails the workflow if any bucket does not meet the policy.**

## Setup

### Prerequisites

- [Node.js](https://nodejs.org/) (v18 or v20 recommended)
- [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials
- [AWS CDK v2 CLI](https://docs.aws.amazon.com/cdk/v2/guide/cli.html) (`npm install -g aws-cdk@latest`)
- [Python 3](https://www.python.org/) (for the helper script in CI)

### Install dependencies

```sh
npm install
```

### Build the project

```sh
npm run build
```

### Bootstrap your AWS environment (only once per account/region)

```sh
npx cdk bootstrap
```

### Deploy the stack

```sh
npx cdk deploy
```

## OPA Policy Enforcement

- OPA policies are stored in the `policies/` directory.
- The main policy (`s3_bucket_tags.rego`) requires every S3 bucket to have `owner` and `environment` tags.
- The GitHub Actions workflow (`.github/workflows/opa-policy-check.yml`) automatically checks all policies on every push or pull request to `main`.
- If any S3 bucket in the synthesized template does not meet the policy, the workflow fails and deployment is blocked.

## Considerations

- **Bucket names must be globally unique.** Adjust the naming logic if deploying to a shared AWS account.
- **OPA/Conftest is not run automatically during `cdk deploy`**; it is enforced in CI/CD.
- **Do not use `RemovalPolicy.DESTROY` and `autoDeleteObjects: true` in production** unless you are sure you want buckets deleted with the stack.
- The helper script for OPA input conversion is in `.github/scripts/cfn_to_opa_input.py`.

## Useful Commands

* `npm run build`   – Compile TypeScript to JS
* `npm run watch`   – Watch for changes and compile
* `npm run test`    – Run unit tests
* `npx cdk deploy`  – Deploy this stack to your AWS account/region
* `npx cdk diff`    – Compare deployed stack with current state
* `npx cdk synth`   – Emit the synthesized CloudFormation template

---

## License

This project is for demonstration and educational purposes.