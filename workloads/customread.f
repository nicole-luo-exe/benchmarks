#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
#
# Copyright 2009 Sun Microsystems, Inc.  All rights reserved.
# Use is subject to license terms.
#

set $dir=/tmp
set $nfiles=1000
set $meandirwidth=1000
set $filesize=16k
set $iosize=16k
set $nthreads=1

set mode quit firstdone

define fileset name=bigfileset,path=$dir,size=$meanfilesize,entries=$nfiles,dirwidth=$meandirwidth,prealloc=100

define process name=filereader,instances=1
{
  thread name=filereaderthread,memsize=10m,instances=$nthreads
  {
    flowop openfile name=openfile1,filesetname=bigfileset,fd=1
    flowop readwholefile name=readfile1,fd=1,iosize=$iosize
    flowop closefile name=closefile1,fd=1
  }
}

echo  "Copyfiles Version 3.0 personality successfully loaded"
usage "Usage: set \$dir=<dir>         defaults to $dir"
usage "       set \$meanfilesize=<size>   defaults to $meanfilesize"
usage "       set \$nfiles=<value>    defaults to $nfiles"
usage "       set \$iosize=<size>     defaults to $iosize"
usage "       set \$meanddirwidth=<value>  defaults to $meandirwidth"
usage "       set \$nthreads=<value>  defaults to $nthreads"
usage "       run"
run 10
