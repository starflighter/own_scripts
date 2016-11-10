#/bin/bash

################################################################################
# Title: Nagios plugin to monitor Raspberry Pi Boot Kernel                     #
# Purpose: Nagios plugin to monitor Installed versus Running Kernel            #
# Author: Kowen Houston                                                        #
# Version                                                                      #
################################################################################
installed_version=`ls /lib/modules/ -Art | tail -n 1`
running_version=`uname -r`
        echo "OK - running kernel = $running_version, installed kernel = $installed_version"
    exit $STATE_OK
