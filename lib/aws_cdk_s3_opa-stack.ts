import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as s3 from 'aws-cdk-lib/aws-s3';

export class AwsCdkS3OpaStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // Generate a date string for uniqueness (YYYYMMDD)
    const dateStr = new Date().toISOString().slice(0, 10).replace(/-/g, '');

    // Create the first S3 bucket with specific tags
    const bucket1 = new s3.Bucket(this, 'FirstBucket', {
      bucketName: `opa-bucket-one-${dateStr}`, // Change to a globally unique name if needed
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });
    cdk.Tags.of(bucket1).add('owner', 'alice');
    cdk.Tags.of(bucket1).add('environment', 'dev');

    // Create the second S3 bucket with a date-based unique name and different tags
    const bucket2 = new s3.Bucket(this, 'SecondBucket', {
      bucketName: `opa-bucket-two-${dateStr}`, // Uses current date for uniqueness
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });
    cdk.Tags.of(bucket2).add('owner', 'bob');
    cdk.Tags.of(bucket2).add('environment', 'prod');
  }
}
