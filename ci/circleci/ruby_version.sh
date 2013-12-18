#!/usr/bin/env bash
case $CIRCLE_NODE_INDEX in
  0)
    rvm use 2.0.0 --default
    ;;
  1)
    rvm use 1.9.3 --default
    ;;
esac

