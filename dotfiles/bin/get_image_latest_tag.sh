#!/bin/bash

DEBUG=FALSE
ACR_NAME=${ACR_NAME:-yammershared}

function debug() {
  if [ $DEBUG = 'TRUE' ] ;then
    echo $@ >&2
  fi
}

function error() {
    echo $@ >&2
}


function usage() {
  echo "$0 [-d|--debug] [--cache-file filename] [--update-cache] [-l|--list] [--version xxx] --image xxx"
  echo "   --image xxx   => the name of the image - will search for a perfect match"
  echo "   --version xxx => the beginning of the tag before the SHA - no need to be complete"
  echo "                    Can also include snapshot or prod"
  echo "   --list        => Print a time sorted list of all match for image + version"
  echo "   --cache-file  => Use a file to read image list instead of ACR. if file does not exist"
  echo "                    read from ACR and create the cache file."
  exit 1
}

if [ -z "$1" ] ; then
  usage
fi

FORMAT=short

while [ -n "$1" ] ; do
<<<<<<< HEAD
  debug "looing at: $1"
=======
>>>>>>> e7d2a0d44894f76ee08e4db1f61e1d3855928c9b
  case $1 in
    -h|--help)
      usage
      ;;
    --cache-file)
      shift
      CACHE_FILE=$1
      ;;
    --update-cache)
      if [ -z "#{JSON_FILE}" ] ; then echo 2> 'you need to spacify a --cache-file' ; usage ; fi
      UPDATE_CACHE=TRUE
      debug "UPDATE_CACHE=${UPDATE_CACHE}"
      ;;
    --image)
      shift
      IMAGE=$1
      debug "IMAGE=${IMAGE}"
      ;;
    --version)
      shift
      VERSION=$1
      debug "VERSION=${VERSION}"
      ;;
    -l|--list)
      FORMAT=list
      debug "FORMAT=$FORMAT"
      ;;
    -d|--debug)
      DEBUG=TRUE
      debug "debug mode on"
      ;;
    *)
      error "unrocognized argument: $1"
      usage
      exit 1
  esac
  shift
done

if [ -z "${VERSION}" ] ; then
  echo >&2 'WARNING: version is empty, will take the absolute latest tag for this image'
fi

if [ -z "${IMAGE}" ] ; then
  error 'missing --image'
  usage
fi

function download_json() {
  debug "Downloading tags for ${IMAGE}"
  az acr repository show-tags -n ${ACR_NAME} --detail --repository ${IMAGE}
}

JSON_FILE=${CACHE_FILE}_${IMAGE}

if [ "${UPDATE_CACHE}" = 'TRUE' ] ; then
  download_json > ${JSON_FILE}
fi

if [ -n "${CACHE_FILE}" ] ; then
  debug "JSON_FILE=${JSON_FILE}"
  json=$(cat ${JSON_FILE})
else
  json=$(download_json)
fi

sorted_list=$(echo ${json} | jq '.[] | [.createdTime,.name] | @csv' | grep "${VERSION}" | sort)
if [ ${FORMAT} = 'short' ] ; then
  echo $sorted_list | tail -1 | \
  sed 's/.*,//g' | sed 's/\\"//g' | sed 's/"//g'
else
  for line in $(echo $sorted_list | sed 's/\\"//g' | sed 's/"//g'); do echo $line ; done
fi
