output "public_ip_frontend" {
  value = module.public_ip_frontend.public_ip_address
}

output "public_ip_backend" {
  value = module.public_ip_backend.public_ip_address
}