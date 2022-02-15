export STORAGE_ACCOUNT_KEY=$(az storage account keys list -n aksefkstorageaccount -g aksefkericrg --query='[0].value' | tr -d '"')

kubectl create secret generic azure-secret \
    --from-literal=azurestorageaccountname=aksefkstorageaccount \
    --from-literal=azurestorageaccountkey=$STORAGE_ACCOUNT_KEY