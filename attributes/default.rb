#
# Cookbook Name:: rsyslog
# Attributes:: rsyslog
#
# Copyright 2009, Opscode, Inc.
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

default["rsyslog"]["log_dir"]          = "/srv/rsyslog"

# rsyslog shipper/remote configuration
default["rsyslog"]["server_ip"]        = nil            # where to send logs
default["rsyslog"]["protocol"]         = "tcp"          # protocol touse when sending logs
default["rsyslog"]["port"]             = "514"          # port to use when sending logs

# rsyslog server/listener options
default["rsyslog"]["server"]                      = false
default["rsyslog"]['listener']["tcp_enabled"]     = false          # listen on TCP?
default["rsyslog"]['listener']["tcp_port"]        = "514"          # what port to listen for TCP on
default["rsyslog"]['listener']["udp_enabled"]     = true           # listen on UDP?
default["rsyslog"]['listener']["udp_port"]        = "514"          # what port to listen for UDP on
default["rsyslog"]['listener']["udp_address"]     = nil            # what ip to bind to, nil means unconfigured, so rsyslog defaults

default["rsyslog"]["server_search"]    = "role:loghost"
default["rsyslog"]["remote_logs"]      = true
default["rsyslog"]["per_host_dir"]     = "%$YEAR%/%$MONTH%/%$DAY%/%HOSTNAME%"
default["rsyslog"]["max_message_size"] = "2k"
default["rsyslog"]["preserve_fqdn"]    = "off"

# The most likely platform-specific attributes
default["rsyslog"]["service_name"]     = "rsyslog"
default["rsyslog"]["user"] = "root"
default["rsyslog"]["group"] = "adm"
default["rsyslog"]["priv_seperation"] = false
default["rsyslog"]["defaults_file"] = "/etc/default/rsyslog"
default['rsyslog']['default_file_template'] = "RSYSLOG_TraditionalFileFormat"
default['rsyslog']['default_forward_template'] = "RSYSLOG_TraditionalForwardFormat"

case node["platform"]
when "ubuntu"
  # syslog user introduced with natty package
  if node['platform_version'].to_f < 10.10 then
    default["rsyslog"]["user"] = "syslog"
    default["rsyslog"]["group"] = "adm"
    default["rsyslog"]["priv_seperation"] = true
  end
when "redhat"
  default["rsyslog"]["defaults_file"] = "/etc/sysconfig/rsyslog"
when "arch"
  default["rsyslog"]["service_name"] = "rsyslogd"
end
