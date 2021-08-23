kubectl get csr -o json | jq '.items[]|.metadata.name' | xargs kubectl certificate approve
