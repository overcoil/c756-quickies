#!/usr/bin/env bash
# Update c756-exer/profiles/ec2.mak with a developer's current settings
# Set the variable values to your settings before running
set -o nounset
set -o errexit
set -o xtrace
sed -e 's|SGI_WFH=.*|SGI_WFH=sg-6dfead08|' -e 's|KEY=.*|KEY=aws|' -e 's|LKEY=.*|LKEY=~/.ssh/aws.pem|' -i .bak ../c756-exer/profiles/ec2.mak
