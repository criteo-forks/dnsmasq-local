# encoding: utf-8
# frozen_string_literal: true
require_relative '../../dnsmasq_local'

describe 'resources::dnsmasq_local::debian::7_9' do
  include_context 'resources::dnsmasq_local'

  let(:platform) { 'debian' }
  let(:platform_version) { '7.9' }

  it_behaves_like 'any platform'
end
