# Docker OpenConnect

[![](https://images.microbadger.com/badges/image/yoep/openconnect.svg)](https://microbadger.com/images/yoep/openconnect)
[![](https://images.microbadger.com/badges/version/yoep/openconnect.svg)](https://microbadger.com/images/yoep/openconnect)

Docker OpenConnect image which can be used in Bitbucket Pipelines for creating a VPN tunnel to your on premise servers.
This allows for communication with your on premise deployment environment such as Kubernetes.

## Bitbucket Pipeline usage

### Proxy Port Tunnel
The example below shows you on how to use this image to connect to a VPN and setup a port proxy through the script tunnel of the VPN.

    pipelines:
      branches:
        master:
          - step:
             name: deploy
             image: yoep/openconnect
             script:
               # connect to vpn
               - vpn-open -u ${VPN_USER} -p ${VPN_PASSWORD} -s ${SERVER} -P ${SERVER_PORT} ${VPN_HOST}
               # execute request over VPN
               - curl https://localhost:61000/apps/v1beta1/namespaces/
               # close vpn
               - vpn-close

### SOCKS5 Proxy
The example below show you on how to user this image to connect to a VPN and setup a SOCKS5 proxy through the script tunnel of the VPN.

    pipelines:
      branches:
        master:
          - step:
             name: deploy
             image: yoep/openconnect
             script:
               # connect to vpn
               - vpn-open -u ${VPN_USER} -p ${VPN_PASSWORD} -5 ${VPN_HOST}
               # execute request over VPN
               - curl --socks5 localhost:61000 https://${SERVER}:8080/apps/v1beta1/namespaces/
               # close vpn
               - vpn-close

## Script manual

### Manual of `vpn-open`

    Open a VPN connection to the given host gateway url.
    
    Usage: vpn-open [options...] <url>
        -u  The VPN username
        -p  The VPN password
        -s  The server hostname or IP to open a proxy tunnel to
        -P  The server port to connect & create a proxy tunnel to
        -L  The local proxy port (default: 61000)
        -5  Use a SOCKS5 proxy instead of a proxy port tunnel
        
### Manual of `vpn-close`

    Close the current VPN connection.
    
    Usage: vpn-close
        -L  The local proxy port (default: 61000)
