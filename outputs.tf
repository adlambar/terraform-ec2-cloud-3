output "instance_ami" {
  value = aws_instance.ubuntu.ami
}

output "instance_arn" {
  value = aws_instance.ubuntu.arn
}

output "instance_id" {
  value = aws_instance.ubuntu.id
}

output "instance_public_ip" {
  value = aws_instance.ubuntu.public_ip
}