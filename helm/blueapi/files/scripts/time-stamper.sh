#!/bin/sh
# Get all PVCs currently mounted by running pods
MOUNTED_PVCS=$(kubectl get pods -n  $RELEASE_NAMESPACE  \
  -o=jsonpath='{.items[*].spec.volumes[*].persistentVolumeClaim.claimName}' | tr ' ' '\n' | sort -u)
NOW=$(date +%s)
#loop through all the pvcs annotating ones thare are mounted
for pvc in $MOUNTED_PVCS; do
    kubectl annotate --overwrite pvc "$pvc" -n  $RELEASE_NAMESPACE  last-used="$NOW"
done
