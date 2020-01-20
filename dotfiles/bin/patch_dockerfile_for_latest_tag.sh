#!/bin/bash

HERE=$(cd $(dirname $0); pwd)

DOCKERFILE=${1:-Dockerfile}
GET_IMAGE_LATEST_TAG=${2:-HERE/get_image_latest_tag.sh}

DEBUG=${DEBUG:-FALSE}
function debug() {
  if [ $DEBUG = 'TRUE' ] ; then
    echo $1 >&2
  fi
}

cat $DOCKERFILE | grep -n -e 'yammershared.azurecr.io..*latest' | while read line_with_number ; do
  debug '-----'
  lineNum=$(echo $line_with_number | cut -d':' -f 1)
  debug lineNum=$lineNum
  line=$(echo $line_with_number | sed 's/^[0-9]*://')
  debug "$line"
  prefix=$(echo -n $line | sed 's/^\(#*\).*/\1/')
  debug prefix=$prefix
  image=$(echo $line | sed 's/.*FROM *yammershared.azurecr.io\/\([^:]*\):.*$/\1/')
  debug image=$image
  version=$(echo -n "$line" | sed -e 's/.*FROM *yammershared.azurecr.io\/[^:]*:\(.*\)/\1/' -e 's/latest//')
  debug "version=$version"
  version_option=''
  if [ -n "$version" ] ; then
    version_option="--version $version"
  fi

  # find latest tag for this image/version
  debug $GET_IMAGE_LATEST_TAG --image $image $version_option --cache-file tag-cache
  tag=$($GET_IMAGE_LATEST_TAG --image $image $version_option --cache-file tag-cache)
  debug tag=$tag

  # build replacement line for the FROM
  new_line="${prefix}FROM yammershared.azurecr.io/${image}:${version}${tag}"
  
  # replace FROM line in place
  HEAD=$(echo "$lineNum - 1" | bc)
  TAIL=$(echo "$lineNum + 1" | bc)
  head -$HEAD $DOCKERFILE >$DOCKERFILE.new
  echo $new_line >>$DOCKERFILE.new
  tail +$TAIL Dockerfile >>$DOCKERFILE.new
  # store trail of base images
  if [ ${prefix} != '#' ] ; then
    echo >>$DOCKERFILE.new "RUN echo '${image}:${version}${tag}' >>/etc/base_images"
  fi
  mv $DOCKERFILE.new $DOCKERFILE
done
