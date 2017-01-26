#!/bin/bash

echo "---------------------"
echo "env_var injecter"
echo "---------------------"
if [ "$env_var_array" == "" ] ; then
  echo "#env_var_array: couldn't find array..."
  exit 1
fi

if [ ! -e $target ] ; then
  touch $target  
  echo "#target: couldn't find target file to inject variables..."
  echo "#target: created target file [$target]..."
fi


echo "#env_var_array: [$env_var_array]"
for i in ${env_var_array[@]} ; do
  echo export $i=$(eval echo \$$i) | tee test.log
  add_env_var="export $i=$(eval echo \$$i)"
  sed -i "1s/^/export $add_env_var\n/" $target
done
