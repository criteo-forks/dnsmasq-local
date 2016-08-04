# encoding: utf-8
# frozen_string_literal: true
#
# Cookbook Name:: dnsmasq-local
# Library:: provider_dnsmasq_local_service_rhel
#
# Copyright 2016, Socrata, Inc.
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

require_relative 'provider_dnsmasq_local_service'

class Chef
  class Provider
    # A Chef provider for Systemd RHEL services.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class DnsmasqLocalServiceRhel < DnsmasqLocalService
      #
      # Patch NetworkManager's config so it won't manage resolv.conf and we
      # can patch Dnsmasq's service script to take ownership of it.
      #
      action :enable do
        service 'NetworkManager' do
          supports(status: true, restart: true)
          action :nothing
        end
        file '/etc/NetworkManager/conf.d/20-dnsmasq.conf' do
          content "[main]\ndns=none"
          notifies :restart, 'service[NetworkManager]', :immediately
        end
        super()
      end

      #
      # Delete the Dnsmasq conf file with NetworkManager.
      #
      action :disable do
        super()
        service 'NetworkManager' do
          supports(status: true, restart: true)
          action :nothing
        end
        file '/etc/NetworkManager/conf.d/20-dnsmasq.conf' do
          action :delete
          notifies :restart, 'service[NetworkManager]', :immediately
        end
      end
    end
  end
end
