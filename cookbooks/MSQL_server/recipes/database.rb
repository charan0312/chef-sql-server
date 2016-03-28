#
# Cookbook Name:: MSQL_server
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# Load the secrets file and the encrypted data bag item that holds the sa password.
password_secret = Chef::EncryptedDataBagItem.load_secret(node['MSQL_server']['secret_file'])
password_data_bag_item = Chef::EncryptedDataBagItem.load('database_passwords', 'sql_server_customers', password_secret)

# Set the node attribute that holds the sa password with the decrypted passoword.
node.default['sql_server']['server_sa_password'] = password_data_bag_item['sa_password']

# Install SQL Server.
include_recipe 'sql_server::server'