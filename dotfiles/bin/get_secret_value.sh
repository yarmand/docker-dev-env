#!/bin/bash

PRINT_ALL=false

ACTION='get_secret'
while [ -n "$1" ] ; do
  case "$1" in
    -h|--help)
      ACTION='help'
      ;;
    -l)
      ACTION='list_secrets'
      ;;
    -i)
      PRINT_ALL=true
      ;;
    *)
      SECRET_NAME=$1
      ;;
  esac
  shift
done

if [ $ACTION = 'help' ] ; then
  echo "usage:"
  echo "   $0 -l [-i]         => List all secrets"
  echo "   $0 [-i] secretname => get one secret"
  echo ""
  echo "   options:"
  echo "       -i (inspect) print all json payload"
  exit 1
fi

az account set --subscription "Yammer Tools"

if [ $ACTION = 'get_secret' ] ; then
  entry=$(az keyvault secret show --vault-name releasemanagement --name $SECRET_NAME)
  if $PRINT_ALL ; then
    printf "%s\n" "$entry"
  else
    printf '%s' "$entry" | jq '.value' | sed 's/"//g'
  fi
fi

if [ $ACTION = 'list_secrets' ] ; then
  entry=$(az keyvault secret list --vault-name releasemanagement)
  if $PRINT_ALL ; then
    printf "$entry"
  else
    printf "$entry" | grep id | cut -d':' -f 3 | sed -e 's/,//g' -e 's/"//g' | sort #xargs basename | sort
  fi
fi
