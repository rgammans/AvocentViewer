#!/bin/bash

JAVAPATH=$APPDIR/usr/jre1.6.0_27/
man() {
 cat - >&2 <<EOF
NAME
   $ARGV0 - Connect to an Avocent (or OEM) IP KVM Switch



EOF

}

usage() {
    
 cat - >&2 <<EOF
$ARGV0 SERVERNAME KVMHOST -p portnumber
$ARGV0 SERVERNAME KVMHOST -r DSQRId

Options:
    -p  Portnumber that the required server is connected to.
    -r  Unique Id of servers KVM 'dongle'
    -t  Alternate title for window
    -u  Username ( default: Admin)
    -P  Password (default is blank)
EOF
}

fatal() {
    for i; do
        echo -e "${i}" >&2
    done
    exit 1
}

UNITSPEC=""
TITLE=""
USERNAME="Admin"
OEM="HP"

optspec="hp:r:t:u:P:"


SERVERNAME=$1; 
case  "x$SERVERNAME" in
    x-h)  ;;
    x-*|x) fatal "Expected Servername before options" ;;
    *) shift ;;
esac

IPADDRESS=$1; 
case  "x$IPADDRESS" in
    x-h)  ;;
    x-*|x) fatal "Expected Hostname before options" ;;
    *) shift ;;
esac

while getopts "$optspec" optchar ; do
    case "$optchar" in
        h) usage; exit 0 ;;
        p) UNITSPEC="p:$OPTARG" ;;
        r) UNITSPEC="r:$OPTARG" ;;
        t) TITLE=$OPTARG ;;
        o) OEM=$OPTARG ;;
        u) USERNAME=$OPTARG ;;
        P) PASSWD=$OPTARG; shift ;;
        *) fatal  "Unknown option: '-${optchar}'" "See '${0} -h for usage" ;;
    esac
done

TITLE=${TITLE:=$SERVERNAME}

# Debugging!
#echo "Viewer with $SERVERNAME  , $IPADDRESS, $OEM, $UNITSPEC, $TITLE, $USERNAME, $PASSWD"
#echo LD_LIBRAY_PATH=$JAVAPATH/lib/amd64 $JAVAPATH/bin/java -Djava.security.properties=$APPDIR/etc/java-6-openjdk/security/java.security -Duser.variant=$OEM -Doem.variant=$OEM -cp './share/avctviewer/*' \
#      com.avocent.video.Nautilus\
#      devicetype=avsp  oem=$OEM path="a:$IPADDRESS,$UNITSPEC,s:$SERVERNAME,e:1,c:0" user=$USERNAME password=$PASSWD title=$SERVERNAME
#
## The 'c:' element of Path is channel; but channel 0 seems to be what need to alwts be specified
LD_LIBRAY_PATH=$JAVAPATH/lib/amd64 $JAVAPATH/bin/java -Djava.security.properties=$APPDIR/etc/java-6-openjdk/security/java.security -Duser.variant=$OEM -Doem.variant=$OEM -cp './share/avctviewer/*' \
      com.avocent.video.Nautilus\
      devicetype=avsp  oem=$OEM path="a:$IPADDRESS,$UNITSPEC,s:$SERVERNAME,e:1,c:0" user=$USERNAME password=$PASSWD title=$SERVERNAME


