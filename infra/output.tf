output "clients_ip" {
    value = module.cluster.client_public_ips
}

output "servers_ip" {
    value = module.cluster.server_public_ips
}

output "nomand_cli" {
    value = "export NOMAD_ADDR=http://${module.cluster.server_lb_ip}:4646"
}

output "nomand_ui" {
    value = "http://${module.cluster.server_lb_ip}:4646/ui"
}

output "private_key" {
    value     = module.cluster.private_key
    sensitive = true
}
