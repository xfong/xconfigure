#!/bin/sh
#############################################################################
# Copyright (c) 2016, Intel Corporation                                     #
# All rights reserved.                                                      #
#                                                                           #
# Redistribution and use in source and binary forms, with or without        #
# modification, are permitted provided that the following conditions        #
# are met:                                                                  #
# 1. Redistributions of source code must retain the above copyright         #
#    notice, this list of conditions and the following disclaimer.          #
# 2. Redistributions in binary form must reproduce the above copyright      #
#    notice, this list of conditions and the following disclaimer in the    #
#    documentation and/or other materials provided with the distribution.   #
# 3. Neither the name of the copyright holder nor the names of its          #
#    contributors may be used to endorse or promote products derived        #
#    from this software without specific prior written permission.          #
#                                                                           #
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS       #
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT         #
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR     #
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT      #
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,    #
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED  #
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR    #
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF    #
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING      #
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS        #
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.              #
#############################################################################
# Hans Pabst (Intel Corp.)
#############################################################################

WGET=$(which wget)
CAT=$(which cat)
RM=$(which rm)

if [ "" != "${WGET}" ] && [ "" != "${CAT}" ] && [ "" != "${RM}" ]; then
  if [ "" != "$1" ]; then
    ARCHS=$2
    KINDS=$3

    if [ "" = "${ARCHS}" ]; then
      ARCHS="snb hsw knl skx"
    fi
    if [ "" = "${KINDS}" ]; then
      KINDS="omp"
      for KIND in ${KINDS} ; do
        ${WGET} -N https://github.com/hfp/xconfigure/raw/master/$1/configure-$1-${KIND}.sh
      done
      for ARCH in ${ARCHS} ; do
        ${WGET} -N https://github.com/hfp/xconfigure/raw/master/$1/configure-$1-${ARCH}.sh
        for KIND in ${KINDS} ; do
          ${WGET} -N https://github.com/hfp/xconfigure/raw/master/$1/configure-$1-${ARCH}-${KIND}.sh
        done
      done
    else
      for ARCH in ${ARCHS} ; do
        for KIND in ${KINDS} ; do
          ${WGET} -N https://github.com/hfp/xconfigure/raw/master/$1/configure-$1-${ARCH}-${KIND}.sh
        done
      done
    fi

    # attempt to get a list of non-default file names, and then download each file
    ${WGET} -N https://github.com/hfp/xconfigure/raw/master/$1/.filelist
    if [ -e .filelist ]; then
      for FILE in $(${CAT} .filelist); do
        ${WGET} -N https://github.com/hfp/xconfigure/raw/master/$1/${FILE}
      done
      # cleanup list of file names
      ${RM} .filelist
    fi
  else
    echo "Please use: $0 <application-name>"
    exit 1
  fi
else
  echo "Error: prerequisites not found!"
  exit 1
fi

