# Docker OpenConnect

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

Manual of the `vpn-open` script:

    Open a VPN connection to the given host gateway url.
    
    Usage: vpn-open [options...] <url>
        -u  The VPN username
        -p  The VPN password
        -s  The server to open a proxy tunnel to
        -P  The server port to create a proxy tunnel to
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
               - bash -c "echo -n ${VPN_PASSWORD} | openconnect -u${VPN_USER} --passwd-on-stdin --script-tun --script 'ocproxy -k 2 -D61000' ${VPN_HOST}" &
               - sleep 5
               # execute request over VPN
               - curl --socks5 localhost:61000 https://${SERVER}:8080/apps/v1beta1/namespaces/
               # close vpn
               - vpn-close
