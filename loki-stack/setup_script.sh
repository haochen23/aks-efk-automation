helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm search repo grafana

# helm show values grafana/loki-stack > loki-stack/values-template.yaml
helm upgrade --install loki-stack grafana/loki-stack --values ./values.yaml -n loki --create-namespace

# kubectl -n loki port-forward svc/loki-stack-grafana 3000:80

# example query
# {component="kube-proxy",namespace="kube-system"} |= "info"