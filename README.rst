Avocent (and OEM Build) IP KVM Client
=====================================

.. note:
    This has only been tested with the HP branded 
    OEM units, but all the parts on the units, and
    here in software is Avocent branded and signed.
    Your mileage may vary with other OEM units, but
    I'm happy to fix to make this a broadly compatible
    as I can.


Why it is this and why is it needed
-----------------------------------

This is an AppImage builder for the Java client for the 
first and second  generation of Avocent IP KVMs. These are
often available relatively cheaply on Ebay and other surplus
sites. This makes these IP KVMs affordable for small scale use.

The downside of these units is that 1) They don't support modern
security protocols, all the units I've had have been locked to 
no hight than TLS1.0, which is generally considered insecure. If
you do use the devices and this App bear in mind that the 
security is not good enough to protect your self if these are on 
the open internet.  This client only supports username/password
authentication.  This means most modern version of linux
and Java will refuse to connect with the default settings.
Additionally the Duffie-Helmann key exchange offered is also
apparently limited to 512 bits, many security policy require 768 bits or 
higher.


The second downside is the only client software only seems to work
with ancient versions of Java. The latest version I've had success
with is 1.60u27 . Any thing later than that doesn't update the screen,
after fetching the initial image. Oddly it does seem to send the 
keypress information.

Due to all of the above, it very easy to have get a working environment
for the Java application, which just apparently appear to stop
working when you update Java or other operating system elements. So
the tools here create a single binary with known good confguriation
files and java binaries.


How do I build the Image
------------------------

This repository contains a YML build file suitable for
the pkg2appimage_ binary builder.

.. _pkg2appimage: https://github.com/AppImage/pkg2appimage

You will also need  copy of the Java 6u27 installer which can
(at the moment anyway) be downloaded from Oracle, and the jar
files used by the client.

The java runtimes should be available from the Oracle Java Archive
at this address https://www.oracle.com/java/technologies/oracle-java-archive-downloads.html ,
under Java SE 6. Your looking for jre-6u27-linux-x64.bin , although earlier versions
work the builder is configure for this one.

There are two Jar files which seem be needed as a minimum , these are:

    - avctVM.jar
    - avctVideo.jar

The easily place to find these jar files is from the onboard
web interface (OBWI) of the KVM device itself. Unfortunately not all of the
units I have found have this enabled. (I suspect it was an extra cost option 
at some point). If you don't have access to the OBWI, I suggest you try to find
your oem support site to find some sort of management client. Often all the 
needed JAR files are in such a client.

If you have access to the webinterface they should be downloadable from 
        http://device/webstart2/<filename>


Once those three files are in the root directory of this repository you
should just be able to run pkg2appimage to create a single  built 
executable you can use to connect to your KVM.

How do I use it
---------------

You nee to provide a server name, and host name or IP address to connect
to the KVM device, and a reference for the appropriate server connected
to that KVM.

The simplest way is to keep a record of the DSRQ-Id of the Server 
interface module for the serves you are interet in and use the -r 
form of the command line below.

::

    ./<AppImage> SERVERNAME KVMHOST -p portnumber
    ./<AppImage> SERVERNAME KVMHOST -r DSQRId

Options:
    -p  Portnumber that the required server is connected to.
    -r  Unique Id of servers KVM 'dongle'
    -t  Alternate title for window
    -u  Username ( default: Admin)
    -P  Password (default is blank)


