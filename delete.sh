# Delete argo
kubectl delete -f install_argo.yaml -n argo

# Delete services in argo ns
kubectl delete $(ls svc/*.yaml | awk ' { print " -f " $1 " -n argo" } ')

# Delete ns
kubectl delete ns argo

# [TODO] Delete secrets
