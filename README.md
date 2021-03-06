Dnsmasq Local Cookbook
======================
[![Cookbook Version](https://img.shields.io/cookbook/v/dnsmasq-local.svg)][cookbook]
[![Build Status](https://img.shields.io/travis/socrata-cookbooks/dnsmasq-local.svg)][travis]
[![Code Climate](https://img.shields.io/codeclimate/github/socrata-cookbooks/dnsmasq-local.svg)][codeclimate]
[![Coverage Status](https://img.shields.io/coveralls/socrata-cookbooks/dnsmasq-local.svg)][coveralls]

[cookbook]: https://supermarket.chef.io/cookbooks/dnsmasq-local
[travis]: https://travis-ci.org/socrata-cookbooks/dnsmasq-local
[codeclimate]: https://codeclimate.com/github/socrata-cookbooks/dnsmasq-local
[coveralls]: https://coveralls.io/r/socrata-cookbooks/dnsmasq-local

Installs Dnsmasq with an opinionated default configuration geared toward
localhost-only improved DNS reliability.

Requirements
============

This cookbook currently supports both Debian-based and RHEL-based platforms.

At least for the time being, it supports Chef 11+, at the expense of some
additional complexity to maintain backwards compatibility.

Usage
=====

Set the attributes you wish and add the default recipe to your run list, or
create a recipe of your own that implements the included Chef resources.

Recipes
=======

***default***

Installs and configures Dnsmasq in an attribute-driven fashion.

Attributes
==========

***default***

The config attribute hash defaults to empty and can be overridden with settings
to be rendered out to Dnsmasq's .conf file:

    default['dnsmasq_local']['config'] = {}

Any option that contains a hyphen should be set as an attribute with an
underscore:

    default['dnsmasq_local']['config']['cache_size'] = 300

Any option that is a boolean with no value can be set to true or false to be
enabled or disabled:

    default['dnsmasq_local']['config']['proxy_dnssec'] = true

Any option that can have multiple entries can be set as either an array
(where all entries will be rendered in the config) or a hash (where entries
set to false will not be rendered):

    default['dnsmasq_local']['config']['server'] = %w(8.8.8.8)

    default['dnsmasq_local']['config']['server']['8.8.8.8'] = true

The options attribute hash defaults to empty and can be overridden with
command line options to run Dnsmasq with. The longform versions of switches
must be used, with the same underscore and boolean rules as for the config: 

    default['dnsmasq_local']['options']['bind_dynamic'] = true
    default['dnsmasq_local']['options']['enable_dbus'] = 'com.example'

Resources
=========

***dnsmasq_local***

A parent resource that combines an app + config + service resource.

Syntax:

    dnsmasq_local 'default' do
      config(cache_size: 0)
      options(bind_dynamic: true)
      action :create
    end

Actions:

| Action    | Description                                  |
|-----------|----------------------------------------------|
| `:create` | Install, configure, and enable+start Dnsmasq |
| `:remove` | Stop+disable and remove Dnsmasq              |

Attributes:

| Attribute | Default   | Description                         |
|-----------|-----------|-------------------------------------|
| config    | `nil`     | A Dnsmasq configuration hash        |
| options   | `nil`     | A Dnsmasq command line options hash |
| Action    | `:create` | Action(s) to perform                |

***dnsmasq_local_app***

A resource for installation and removal of the Dnsmasq app packages.

Syntax:

    dnsmasq_local_app 'default' do
      action :install
    end

Actions:

| Action     | Description                   |
|------------|-------------------------------|
| `:install` | Install the Dnsmasq package   |
| `:upgrade` | Upgrade the Dnsmasq package   |
| `:remove`  | Uninstall the Dnsmasq package |

Attributes:

| Attribute | Default    | Description                               |
|-----------|------------|-------------------------------------------|
| version   | `nil`      | Install a specific version of the package |
| action    | `:install` | Action(s) to perform                      |

***dnsmasq_local_config***

A resource for generating Dnsmasq configurations.

Syntax:

    dnsmasq_local_config 'default' do
      config(cache_size: 100)
      no_hosts false
      server %w(8.8.8.8 8.8.4.4)
      interface(eth0: false, eth1: true)
      action :create
    end

Actions:

| Action    | Description                       |
|-----------|-----------------------------------|
| `:create` | Write out the Dnsmasq config file |
| `:remove` | Delete the Dnsmasq config file    |

Attributes:

| Attribute       | Default    | Description                           |
|-----------------|------------|---------------------------------------|
| config          | See below  | A complete config hash \*             |
| interface       | ''         | Listen only on the loopback interface |
| cache_size      | 0          | Disable caching
| no_hosts        | true       | Do not DNSify `/etc/hosts`            |
| bind_interfaces | true       | Bind only to listening interfaces     |
| query_port      | 0          | Use a static, ephemeral return port   |
| \*\*            | `nil`      | Varies                                |
| action          | `:create`  | Action(s) to perform                  |

\* A config attribute that is passed in will override the entirety of the
  default config, whereas individual attributes passed in will be merged with
  it.

\*\* Any unrecognized attribute that is passed in will be assumed to be a
  correct Dnsmasq setting and rendered out to its config. These attributes'
values can be `true`, `false`, integers, strings, arrays, or hashes.

***dnsmasq_local_service***

A resource for the managing the Dnsmasq service.

Syntax:

    dnsmasq_local_service 'default' do
      options(bind_dynamic: true)
      enable_dbus 'com.example'
      action [:create, :enable, :start]
    end

Actions:

| Action     | Description                                        |
|------------|----------------------------------------------------|
| `:create`  | Set up `/etc/default/dnsmasq` and any init patches |
| `:remove`  | Remove `/etc/default/dnsmasq` and any init patches |
| `:enable`  | Enable the service                                 |
| `:disable` | Disable the service                                |
| `:start`   | Start the service                                  |
| `:stop`    | Stop the service                                   |
| `:restart` | Restart the service                                |

Attributes:

| Attribute | Default                      | Description                |
|-----------|------------------------------|----------------------------|
| options   | See below                    | A complete options hash \* |
| \*        | `nil`                        | Varies                     |
| action    | `[:create, :enable, :start]` | Action(s) to perform       |

\* Command line options can be passed in either as one complete `options` hash,
   or as individual attribute calls for each option.

Providers
=========

***Chef::Provider::DnsmasqLocal***

Provider that wraps each of the Dnsmasq component resources.

***Chef::Provider::DnsmasqLocalApp***

Parent provider for managing Dnsmasq app packages.

***Chef::Provider::DnsmasqLocalAppDebian***

The Ubuntu/Debian implementation of the app provider.

***Chef::Provider::DnsmasqLocalAppRhel***

The RHEL implementation of the app provider.

***Chef::Provider::DnsmasqLocalConfig***

Platform-agnostic provider for managing Dnsmasq config files.

***Chef::Provider::DnsmasqLocalService***

Parent provider for managing the Dnsmasq service.

***Chef::Provider::DnsmasqLocalServiceDebian***

The Ubuntu/Debian implementation of the service provider. As of 16.04, Ubuntu
has yet to switch Dnsmasq to either Upstart or Systemd, so only the single
provider is needed.

***Chef::Provider::DnsmasqLocalServiceRhelSystemd***

The RHEL >= 7 Systemd implementation of the service provider. Also patches the
Systemd config to pass the desired command line options to Dnsmasq via
`/etc/default/dnsmasq`.

***Chef::Provider::DnsmasqLocalServiceRhelSysvinit***

The RHEL < 7 init implementation of the service provider. Also patches the
init script to pass the desired command line options to Dnsmasq via
`/etc/default/dnsmasq`.

Contributing
============

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for the new feature; ensure they pass (`rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

License & Authors
=================
- Author: Jonathan Hartman <jonathan.hartman@socrata.com>

Copyright 2016, Socrata, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
