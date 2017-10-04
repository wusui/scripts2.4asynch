#! /bin/bash -f
#
# Accept a command name, and a list of .sites.
#
# The command is copied from the remote machine that is running this set of scripts
# (magna002 for instance).  It is placed in /tmp on the remote machines to be executed
# there.  The rest of the parameters are the short names of machines on which the
# /tmp code will be executed.
#
source ./globaldefs.sh
remote_command=${1}
shift
parms_values=${1}
shift
octo_name=${octoname:-'wusui'}
for i in $*; do
    if [[ ${remote_command} == /tmp/* ]]; then
        ssh -t -A ${octo_name}@$i sudo rm -rf ${remote_command}
        scp ${remote_command##*/} ${octo_name}@$i:/tmp
    fi
    ssh -t -A ${octo_name}@$i sudo ${remote_command} ${parms_values}
done
