#!/bin/bash
# Assumes: run on CLC, eucarc is available, has password-less ssh access to all CCs

EUCALYPTUS=/
EUCARC=/root/eucarc
source ${EUCARC}
for f in $(euca-describe-services -T cluster | awk '{print $3}' | sort | uniq); do 
    echo "#### $f ####"
    CC_IPS=$(euca-describe-services -T cluster | grep $f | awk '{print $7}' | sed 's/http:..\(.*\):877.*/\1/g') # CC IPs
    NODES=$(for cc in ${CC_IPS}; do ssh ${cc} grep NODES $EUCALYPTUS/etc/eucalyptus/eucalyptus.conf; done | xargs sed 's/NODES=//g;s/[" ]/\n/g' | sort | uniq -c)
    if echo "${NODES}" | egrep " *1 " >/dev/null 2>&1; then
        echo FOUND MISCONFIGURED NODE: $(echo "${NODES}" | egrep " *1 ")
    fi
done

