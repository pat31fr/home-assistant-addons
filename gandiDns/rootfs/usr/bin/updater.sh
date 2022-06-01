#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: GandiDns
#
# GandiDNS add-on for Hass.io.
# This add-on update public IP on Gandi API.
# ==============================================================================

get_current_ip() {
    # echo "$(curl -s https://api.ipify.org)"
    echo "$(curl -s ifconfig.me)"
}

get_gandi_ip() {
    domain=$1
    record=$2
    api_key=$3
    
    bashio::log.debug "[Gandi] - Get data for - ${domain} - ${record}"
    echo "$(curl -s -H "Authorization: Apikey ${api_key}" https://api.gandi.net/v5/livedns/domains/${domain}/records/${record}/A | jq -r '.rrset_values[0]')"
}

update_gandi_ip() {
    domain=$1
    record=$2
    api_key=$3
    ip=$4
    payload='{"rrset_values": ["'"${ip}"'"],"rrset_ttl": 300}'
    bashio::log.debug "[Gandi] - Update record - ${domain} - ${record}"
    echo "$(curl -s -g -X PUT -H "Content-Type: application/json" -d "${payload}" -H "Authorization: Apikey ${api_key}" https://api.gandi.net/v5/livedns/domains/${domain}/records/${record}/A)"

}
# ==============================================================================
# RUN LOGIC
# ------------------------------------------------------------------------------
main() {
    local domain
    local records
    local api_key
    local current_ip
    local gandi_ip


    domain=$(bashio::config 'domain')
    records=$(bashio::config 'records')
    api_key=$(bashio::config 'api_key')

    bashio::log.trace "${FUNCNAME[0]}"
    bashio::log.info "Updater Started"
    while true; do
        current_ip=$(get_current_ip)
        bashio::log.debug "[GandiDns] - Current ip is ${current_ip}"

        gandi_ip=$(get_gandi_ip "${domain}" "${records[0]}" "${api_key}")
        bashio::log.debug "[GandiDns] - Gandi ip is ${gandi_ip}"

        if [ "${current_ip}" = "${gandi_ip}" ]; then
            bashio::log.debug "[GandiDns] - IP's are correct"
            sleep 600
        else
            bashio::log.info "[GandiDns] - Ip did not match, need an update (gandi_ip=${gandi_ip}, current_ip=${current_ip})"
            for record in ${records}
            do
                bashio::log.info "[GandiDns] - Updating reccord ${record}"
                res=$(update_gandi_ip "${domain}" "${record}" "${api_key}" "${current_ip}")
                bashio::log.info "[GandiDns] - Reccord ${res}"
                bashio::log.info "[GandiDns] - Domain ${record}.${domain} updated with IP ${current_ip}"
            done
        sleep 600
        fi
    done
    
}
main "$@"
