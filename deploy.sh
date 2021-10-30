# Create ns argo
kubectl create ns argo

# Create rolebinding with admin role in admin ns
kubectl create rolebinding namespace-admin --clusterrole=admin --serviceaccount=default:default -n argo

# Deploy argo in argo ns
kubectl apply -f install_argo.yaml -n argo

#--------------- Install argo CLI ------------

echo ">>>>>>> Installing argo cli to current directory"
# Download the binary
curl -sLO https://github.com/argoproj/argo-workflows/releases/download/v3.2.3/argo-linux-amd64.gz

# Unzip
gunzip argo-linux-amd64.gz

# Rename
mv argo-linux-amd64 argo

# Make binary executable
chmod +x argo

echo ">>>>>>> CLI argo is insalled successfully"
echo ">>>>>>> Applying services and creating workflows"

# Apply services in argo ns
kubectl apply $(ls svc/*.yaml | awk ' { print " -f " $1 " -n argo" } ')

# Create workflows in argo ns
./argo cron create $(ls cronwf/*.yaml | awk ' { print $1 " -n argo --strict=false " } ')

