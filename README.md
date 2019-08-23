# Docker OpenConnect

Docker OpenConnect image which can be used in Bitbucket Pipelines for creating a VPN tunnel to your on premise servers.
This allows for communication with your on premise deployment environment such as Kubernetes.

## Bitbucket Pipeline usage

The example below shows you on how to use this image to connect to a VPN and setup a proxy through the script tunnel of the VPN.

    pipelines:
      branches:
        master:
          - step:
             name: deploy
             image: yoep/openconnect
             script:
               # connect to vpn
               - bash -c "echo -n ${VPN_PASSWORD} | openconnect -u${VPN_USER} --passwd-on-stdin --script-tun --script 'ocproxy -L61000:${SERVER}:8080' ${VPN_HOST}" &
               - sleep 5
