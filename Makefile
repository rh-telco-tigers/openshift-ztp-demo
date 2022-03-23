all: pull-vault pull-external-secrets

pull-vault:
	rm -rf base/operators/vault-server/chart
	helm repo add hashicorp https://helm.releases.hashicorp.com || true
	helm pull hashicorp/vault  --untar --untardir=base/operators/vault-server
	mv base/operators/vault-server/vault base/operators/vault-server/chart
	helm template vault-server  base/operators/vault-server/chart -f base/operators/vault-server/override-values.yaml  --namespace vault > base/operators/vault-server/all-in-one-template.yaml

pull-external-secrets:
	rm -rf base/operators/external-secrets/chart
	helm repo add external-secrets https://external-secrets.github.io/kubernetes-external-secrets/ || true
	helm pull external-secrets/external-secrets --untar --untardir=base/operators/external-secrets/
	mv base/operators/external-secrets/external-secrets base/operators/external-secrets/chart
	helm template external-secrets base/operators/external-secrets/chart -f base/operators/external-secrets/override-values.yaml --namespace external-secrets > base/operators/external-secrets/all-in-one-template.yaml
