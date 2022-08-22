#!/bin/bash
kubectl create configmap mongo-replica --from-file=script.sh=script.sh
kubectl create -f mongodb-sts-bkp.yaml

