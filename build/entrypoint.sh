#!/bin/sh

sed "s/^Port .*$/Port 8888/" -i /etc/tinyproxy.conf
/usr/bin/tinyproxy -c /etc/tinyproxy.conf

/usr/local/bin/microsocks -i 0.0.0.0 -p 8889 & 

run () {
  # Start openconnect
  #if [[ -z "${DSID}" ]]; then
    openconnect --juniper -C "DSID=${DSID}" $OPENCONNECT_URL
  #fi
}

until (run); do
  echo "openconnect exited. Restarting process in 60 seconds…" >&2
  sleep 60
done
