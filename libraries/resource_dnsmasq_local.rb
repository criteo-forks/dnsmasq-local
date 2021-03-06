# encoding: utf-8
# frozen_string_literal: true
#
# Cookbook Name:: dnsmasq-local
# Library:: resource_dnsmasq_local
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

require 'chef/resource/lwrp_base'

class Chef
  class Resource
    # A main Chef resource for dnsmasq installation and configuration.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class DnsmasqLocal < LWRPBase
      self.resource_name = :dnsmasq_local
      actions :create, :remove
      default_action :create

      #
      # Support passing a dnsmasq config in as one big (or small) hash.
      #
      attribute :config, kind_of: Hash, default: {}

      #
      # Support passing command line options for dnsmasq as a hash.
      #
      attribute :options, kind_of: Hash, default: {}
    end
  end
end
