#!/usr/bin/env bash
# Dependencies lm_sensors

sensors | awk '/Package/ {printf "%.0f°C", substr($4, 2, length($4)-3)}'
