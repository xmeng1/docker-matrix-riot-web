#!/usr/bin/env bash

if [ -z "${HOME_SERVER_URL}" ]; then
	echo "HOME_SERVER_URL not set, 'https://matrix.deepnetsecurity.com:8448' by default"
	export HOME_SERVER_URL="https://matrix.deepnetsecurity.com:8448"
fi

if [ -z "${IDENTITY_SERVER_URL}" ]; then
	echo "IDENTITY_SERVER_URL not set, 'https://matrix.deepnetsecurity.com:8449' by default"
	export IDENTITY_SERVER_URL="https://matrix.deepnetsecurity.com:8449"
fi

if [ -z "${BRAND}" ]; then
	echo "BRAND not set, 'Riot' by default"
	export BRAND="DeepnetSecurity"
fi

generate_config() {
cat <<EOF > /var/www/riot/config.json
{
    "default_hs_url": "${HOME_SERVER_URL}",
    "default_is_url": "${IDENTITY_SERVER_URL}",
    "brand": "${BRAND}",
    "integrations_ui_url": "https://scalar.vector.im/",
    "integrations_rest_url": "https://scalar.vector.im/api",
    "bug_report_endpoint_url": "https://riot.im/bugreports/submit",
    "features": {
        "feature_groups": "labs",
        "feature_pinning": "labs"
    },
    "default_federate": true,
    "roomDirectory": {
        "servers": [
            "matrix.org"
        ]
    },
    "welcomeUserId": "@riot-bot:matrix.deepnetsecurity.com",
    "piwik": {
        "url": "https://piwik.riot.im/",
        "siteId": 1
    }
}
EOF
}

generate_config

exec "$@"
