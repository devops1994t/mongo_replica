#!/bin/bash
kubectl delete sts mongod
kubectl delete pvc mongodb-persistent-storage-claim-mongod-0 mongodb-persistent-storage-claim-mongod-1 mongodb-persistent-storage-claim-mongod-2
kubectl delete cm mongo-replica
