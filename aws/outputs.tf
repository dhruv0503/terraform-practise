output "bucket_name" {
  description = "The name of the S3 bucket created."
  value       = aws_s3_bucket.demo_bucket.bucket
}

output "instance_id" {
  description = "The ID of the EC2 instance created."
  value       = aws_instance.terraform_demo_ec2_instance.id  
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.terraform_demo_ec2_instance.public_ip
}

