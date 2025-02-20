output "public_ip" {
	value = aws_instance.my_host.public_ip
	description = "Public IP of the EC2 instance"
}

resource "local_sensitive_file" "my_ssh_pem_file" {
	filename = pathexpand("~/.ssh/${aws_key_pair.my_ssh_key.key_name}.pem")
	file_permission = "600"
	directory_permission = "700"
	content = tls_private_key.my_ssh_private_key.private_key_pem
}
