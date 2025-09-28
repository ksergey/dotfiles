#!/usr/bin/env bash

matugen image $(swww query | sed 's/^.*image:\ //')
