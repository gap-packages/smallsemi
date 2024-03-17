#!/bin/bash
set -e

gaplint --disable W004 $@ *.g gap/* doc/*.xml tst/*.tst tst/*.g
