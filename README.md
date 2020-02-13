# k3d dev env

This sets up a local Kubernetes cluster with [k3d](https://github.com/rancher/k3d) and
[Tanka](https://github.com/grafana/tanka/).

```
export CLUSTER_NAME=k3d
export SERVER=localhost
./create-k3d-cluster
export KUBECONFIG="$(k3d get-kubeconfig --name=$CLUSTER_NAME):$HOME/.kube/config"
tk env set --server-from-context $CLUSTER_NAME environments/default/
./install
```

Go to http://localhost:8080/
