#!/bin/bash

JAVAPATH=$APPDIR/usr/jre1.6.0_27/
man() {
 cat - >&2 <<EOF
NAME
   $ARGV0 - Connect to an Lenovo IP KVM Switch


EOF

}

usage() {
    
 cat - >&2 <<EOF
$ARGV0 arguments [option=value]*

Options:
    ip: Ip address of KVM switch
    helpurl: ?
    user: Numeric user id in hex. Eg 0x66334873
    passwd: password
    apcp: Must be '1'
    version: Must be '2'
    kmport: ?
    vport: ?
    title: Title for window.
EOF
}

LD_LIBRAY_PATH=$JAVAPATH/lib/amd64 $JAVAPATH/bin/java -Djava.security.properties=$APPDIR/etc/java-6-openjdk/security/java.security  -cp './share/avctviewer/*' \
      com.avocent.ibmc.kvm.Main\
      "$@"


