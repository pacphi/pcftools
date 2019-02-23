#!/bin/bash

# Disables all buildpacks that target cflinuxfs2 stack
# Net result is that developers won't be able to cf push targeting this stack with any buildpack that had been previously installed and configured to target it
# @see https://docs.cloudfoundry.org/devguide/deploy-apps/stacks.html#available-stacks

buildpack_array=('staticfile_buildpack' 'java_buildpack_offline' 'ruby_buildpack' 'dotnet_core_buildpack' 'nodejs_buildpack' 'go_buildpack' 'python_buildpack' 'php_buildpack' 'binary_buildpack')

for b in "${buildpack_array[@]}"; do
    cf update-buildpack "$b" -s cflinuxfs2 --disable
done
