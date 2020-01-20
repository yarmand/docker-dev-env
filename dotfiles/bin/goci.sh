#!/bin/bash

ginkgo watch -r --trace --afterSuiteHook 'goci-notify.sh (ginkgo-suite-passed)'

