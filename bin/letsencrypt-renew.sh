#!/bin/bash
/opt/letsencrypt/letsencrypt-auto renew -q --post-hook "/opt/webctl/bin/reload_webserver"

