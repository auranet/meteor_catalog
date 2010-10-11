#! /bin/bash
#
# M80 ---- see the License file for restrictions
#



PROGNAME=${0##*/}
TMPFILE=/tmp/${PROGNAME}.$$

if [ -n "${DEBUG}" ]; then	
	set -x
fi

PSCMD="ps axc"  








#
# $Header: /cvsroot/m80/m80/lib/shell/printmsg.sh,v 1.1.1.1 2003/11/26 22:24:33 bretweinraub Exp $
#
# Function:	printmsg
#
# Description:	generic error reporting routine.
#               BEWARE, white space is stripped and replaced with single spaces
#
# Call Signature:
#
# Side Effects:
#
# Assumptions:
#

printmsg () {
    if [ -z "${QUIET}" ]; then 
	if [ $# -ge 1 ]; then
	    /bin/echo -n ${M80_OVERRIDE_DOLLAR0:-$PROGNAME}:\($$\) >&2
		while [ $# -gt 0 ]; do /bin/echo -n " "$1 >&2 ; shift ; done
		if [ -z "${M80_SUPRESS_PERIOD}" ]; then
		    echo . >&2
		else
		    echo >&2
		fi
	fi
    fi
}


#
# Function:	cleanup
#
# Description:	generic KSH funtion for the end of a script
#
# History:	02.22.2000	bdw	passed error code through to localclean
#
# $Id: cleanup.sh,v 1.2 2004/04/06 22:42:02 bretweinraub Exp $
#

cleanup () {
    export EXITCODE=$1
    shift
    if [ $# -gt 0 ]; then
	printmsg $*
    fi
    if [ -n "${DQITMPFILE}" ]; then
	rm -f ${DQITMPFILE}
    fi
    if [ -n "${LOCALCLEAN}" ]; then
	localclean ${EXITCODE} # this function must be set
    fi
    if [ ${EXITCODE} -ne 0 ]; then
	# this is an error condition
	printmsg exiting with error code ${EXITCODE}
    else
	printmsg done
    fi
    exit ${EXITCODE}
}

trap "cleanup 1 caught signal" INT QUIT TERM HUP 2>&1 > /dev/null


require () {
    while [ $# -gt 0 ]; do
	#printmsg validating \$${1}
	derived=$(eval "echo \$"$1)
	if [ -z "$derived" ];then
	    printmsg \$${1} not defined
	    usage
	fi
	shift
    done
}



# 
# filesize () : returns the number of bytes for a file; more reliable than ls.
#

filesize () {
    if [ $# -ne 1 ]; then
	cleanup 1 illegal arguments to shell function filesize
    fi
    echo $1 | perl -nle '@stat = stat($_); print $stat[7]'
}


#
# Function:	docmd
#
# Description:	a generic wrapper for ksh functions
#
# $Id: docmd.sh,v 1.1.1.1 2003/11/26 22:24:33 bretweinraub Exp $

docmd () {
    if [ $# -lt 1 ]; then
	return
    fi
    #print ; eval "echo \* $*" ; print
    eval "echo '$*'"
    eval $*
    RETURNCODE=$?
    if [ $RETURNCODE -ne 0 ]; then
	cleanup $RETURNCODE command \"$*\" returned with error code $RETURNCODE
    fi
    return 0
}


#
# Function:	docmdi
#
# Description:	execute a command, but ignore the error code
#
# $Id: docmdi.sh,v 1.1.1.1 2003/11/26 22:24:33 bretweinraub Exp $

docmdi () {
    if [ $# -lt 1 ]; then
	return
    fi
#    print ; eval "echo \* $*" ; print
    eval "echo '$*'"
    eval $*
    export RETURNCODE=$?
    if [ $RETURNCODE -ne 0 ]; then
	printmsg command \"$*\" returned with error code $RETURNCODE, ignored
    fi
    return $RETURNCODE
}


#
# Function:	checkfile
#
# Description:	This function is used to check whether some file ($2) or
#               directory meets some condition ($1).  If not print out an error
#               message ($3+).
#
# $Id: checkfile.sh,v 1.1.1.1 2003/11/26 22:24:33 bretweinraub Exp $

checkfile () {
    if [ $# -lt 2 ]; then
	cleanup 1 illegal arguments to the checkfile \(\) function
    fi
    FILE=$2
    if [ ! $1 $FILE ]; then
	shift; shift
	cleanup 1 file $FILE $*
    fi
}

checkNotFile () {
    if [ $# -lt 2 ]; then
	cleanup 1 illegal arguments to the checkNotfile \(\) function
    fi
    FILE=$2
    if [ $1 $FILE ]; then
	shift; shift
	cleanup 1 file $FILE $*
    fi
}



SSHCOMMAND="ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=publickey"


#
# shellfunc : show
#
# usage : show var1 var2 var3

show () {
    while [ $# -gt 0 ]; do
	this=$1
	that=$(eval "echo \$"$this)
	printmsg using $this as $that
	shift
    done
}




unset QUIET


usage () {
  printmsg  I am unhappy ...... a usage message follows for your benefit
  printmsg  Usage is -s {submodule} 

printmsg  Required variables: submodule 


  cleanup 1
} 

OPTIND=0
while getopts :s: c 
    do case $c in        
	s) export submodule=$OPTARG;;
	:) printmsg $OPTARG requires a value
	   usage;;
	\?) printmsg unknown option $OPTARG
	   usage;;
    esac
done






test -z "${submodule}" && {
	printmsg missing value for submodule
	usage
}








status () {
    docmd git submodule status
}

status

app=$(basename $(dirname `pwd`))

#for submodule in meteor; do
    submodule_path=vendor/plugins/$submodule
    docmd cd $submodule_path
    docmd git pull origin master
    docmd cd ../../..
    docmd git commit -m \'"updating $submodule in application $app"\' $submodule_path
    status
    docmd git push origin master
#done

cleanup 0

    
