Dnsmasq Local Cookbook CHANGELOG
================================

Unreleased
----------

v1.1.0 (2016-08-11)
-------------------
- Remove 'proxy-dnssec' as a default setting

v1.0.0 (2016-08-09)
-------------------
- Add support for RHEL and RHEL-alike platforms
- Replace the "environment" attribute/property with command line "options"
- Add an :upgrade action to the dnsmasq_local_app resource
- Add a "version" attribute to the dnsmasq_local_app resource
- Bypass NetworkManager's Dnsmasq management if it's running

v0.5.0 (2016-07-26)
-------------------
- Support hashes as config properties

v0.4.0 (2016-06-24)
-------------------
- Take over management of the Dnsmasq environment variables
- Add a warning comment to all Chef-managed config files

v0.3.0 (2016-05-26)
-------------------
- Fix custom config properties/attributes under Chef 11
- Support arrays for config attributes with >1 value (e.g. "server")

v0.2.0 (2016-05-18)
-------------------
- Ensure the APT cache is up to date before installing
- Refactor config merging to avoid attribute collision warnings

v0.1.0 (2016-05-06)
-------------------
- Initial release!

v0.0.1 (2016-04-25)
-------------------
- Development started
