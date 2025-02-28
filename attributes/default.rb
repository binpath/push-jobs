#
# Cookbook Name:: activemq
# Attributes:: default
#
# Copyright 2013-2016 Chef Software, Inc. <legal@chef.io>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['push_jobs']['package_url']                 = 'https://packages.chef.io/files/stable/push-jobs-client/2.1.4/el/6/push-jobs-client-2.1.4-1.el6.x86_64.rpm'
default['push_jobs']['package_checksum']            = 'e74fddb332e2aa8db0658a6e5ca3b412fcd28bf84de3c3a4d6e9832e89c59b6f'
default['push_jobs']['package_version']             = '2.1.4'

default['push_jobs']['config']['template_cookbook'] = nil
default['push_jobs']['whitelist']                   = { 'chef-client' => 'chef-client' }
default['push_jobs']['environment_variables']       = { 'LC_ALL' => 'en_US.UTF-8' }

# must be set to true in order to communicate with Push Jobs 1.X server
default['push_jobs']['allow_unencrypted']           = false

# These variables control whether we validate ssl
default['push_jobs']['chef']['verify_api_cert']     = true
default['push_jobs']['chef']['ssl_verify_mode']     = :verify_none

# These can be overridden so that we can use chef_zero based installers to set up push
default['push_jobs']['chef']['chef_server_url']     = nil
default['push_jobs']['chef']['node_name']           = nil

# Show timestamps in log by default.
default['push_jobs']['chef']['include_timestamp']   = true

case node['platform_family']
when 'debian', 'rhel', 'suse'
  default['push_jobs']['init_style']                 = nil # auto detect based on system
  default['push_jobs']['chef']['include_timestamp']  = false
  default['push_jobs']['chef']['client_key_path']    = '/etc/chef/client.pem'
  default['push_jobs']['chef']['trusted_certs_path'] = '/etc/chef/trusted_certs'
  default['push_jobs']['chef']['install_path']       = nil
  default['push_jobs']['chef']['exec_name']          = nil
when 'windows'
  default['push_jobs']['service_string']             = 'service[push-jobs-client]'
  default['push_jobs']['init_style']                 = 'windows'

  # default is this comes from url, but make it overrideable
  default['push_jobs']['package_name']               = nil
  default['push_jobs']['service_name']               = nil
  default['push_jobs']['chef']['client_key_path']    = 'c:\chef\client.pem'
  default['push_jobs']['chef']['trusted_certs_path'] = 'c:\chef\trusted_certs'
end

default['push_jobs']['logging_level'] = 'info'
