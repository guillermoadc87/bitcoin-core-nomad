#!/bin/sh
set -e

echo $(ls /tmp)

# Environment variables are set by packer
/tmp/install-nomad --version "${NOMAD_VERSION}"

/tmp/install-consul --version "${CONSUL_VERSION}"