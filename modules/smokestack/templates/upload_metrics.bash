#!/bin/bash
# Script to upload SmokeStack metrics data to Librato

METRICS_FILE="/tmp/smokestack_metrics.txt"
TMP_METRICS_FILE="/tmp/smokestack_metrics.processing"
FULL_METRICS_BACKUP="$HOME/metrics_full_backup.txt"

if [ -f "$METRICS_FILE" ]; then

mv $METRICS_FILE $TMP_METRICS_FILE
cat $TMP_METRICS_FILE >> $FULL_METRICS_BACKUP
for LINE in $(cat $TMP_METRICS_FILE); do

  MEASURE_TIME=$(echo "$LINE" | sed -e 's|^\([^\:]*\)\:.*|\1|')
  TOTAL_TIME=$(echo "$LINE" | sed -e 's|^[^\:]*:\([^\:]*\)\:.*|\1|')
  METRIC_NAME=$(echo "$LINE" | sed -e 's|^[^\:]*:[^\:]*:\([^\:]*\)\:.*|\1|')
  METRIC_SOURCE=$(echo "$LINE" | sed -e 's|^[^\:]*:[^\:]*:[^\:]*:\([^$]*\)|\1|')

  curl \
  -u <%= librato_email %>:<%= librato_api_token %> \
  -d "gauges[0][name]=$METRIC_NAME" \
  -d "gauges[0][value]=$TOTAL_TIME" \
  -d "gauges[0][source]=$METRIC_SOURCE" \
  -d "gauges[0][measure_time]=$MEASURE_TIME" \
  -X POST \
  https://metrics-api.librato.com/v1/metrics

done

rm $TMP_METRICS_FILE

fi
