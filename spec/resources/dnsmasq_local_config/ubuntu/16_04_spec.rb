# encoding: utf-8
# frozen_string_literal: true
require_relative '../../dnsmasq_local_config'

describe 'resources::dnsmasq_local_config::ubuntu::16_04' do
  include_context 'resources::dnsmasq_local_config'

  let(:platform) { 'ubuntu' }
  let(:platform_version) { '16.04' }

  it_behaves_like 'any platform'
end
