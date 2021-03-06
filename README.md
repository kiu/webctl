webctl
===================
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](https://tldrlegal.com/license/mit-license)

What is this?
-------------
A few scripts I use to setup new nginx instances.

Install
------------------
* `sudo git clone https://github.com/kiu/webctl /opt/webctl`
* Add `include /www/*/etc/*.nginx;` to your `nginx.conf` `http` config

Usage
------------------

#### ./bin/generate-domain.sh <FQDN>
* Setup a basic configuration under `/www/<reversed FQDN>/`
* Reloading webserver to activate new configuration

#### ./bin/generate-ssl.sh <FQDN>
* Generate basic https configuration for `./bin/generate-domain.sh` generated domains
* Retrieve letsencrypt certificate (assuming a letsencrypt install under /opt/letsencrypt)
* Reloading webserver to activate new configuration

#### ./bin/reload_webserver.sh
* Used by the other scripts to reload the webserver configuration

#### ./bin/letsencrypt-renew.sh
* Auto-renew letencrypt certificates through cron: `ln -s /opt/webctl/bin/letsencrypt-renew.sh /etc/cron.daily/`

#### ./conf/nginx-www
* Make new directory structure known to logrotate
* `ln -s /opt/webctl/conf/nginx-www /etc/logrotate.d`

License
------------------

Contents are MIT Licensed, see the LICENSE file for more info.
