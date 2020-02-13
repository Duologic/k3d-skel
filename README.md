# Reference implementation with k3d and tanka

This sets up a local Kubernetes cluster with Grafana and Prometheus
.

## Requirements

* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [k3d](https://github.com/rancher/k3d/)
* [tanka](https://github.com/grafana/tanka/)
* [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler/)

## Installation

By default, this installs a local k3d cluster.

```bash
export CLUSTER_NAME=k3d
export SERVER=localhost

./create-k3d-cluster
export KUBECONFIG="$(k3d get-kubeconfig --name=$CLUSTER_NAME):$HOME/.kube/config"
./install
```

Go to http://localhost:8080/

## Remote Docker

It can be expanded to use a remote Docker host.

```bash
export CLUSTER_NAME=k3d
export SERVER=<remote-ip>
export DOCKER_HOST=tcp://<remote-ip>:<remote-port>

./create-k3d-cluster
export KUBECONFIG="$(k3d get-kubeconfig --name=$CLUSTER_NAME):$HOME/.kube/config"
tk env set --server-from-context $CLUSTER_NAME environments/default/
./install
```

Go to http://*remote-ip*:8080/
