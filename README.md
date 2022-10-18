# demo-k8s

A demonstration Kubernetes cluster configuration.

## Summary

This demo cluster configuration includes a script to install the Traefik Helm chart and then deploy services with `kubectl`. It uses Traefik to forward paths starting with `/api/` to a [demonstration Go API service](https://github.com/joberly/demo-go-api). This is a service that I wrote and set up to test and build and push a container image to `ghcr.io/joberly/demo-go-api:latest`. The only endpoint available via this cluster setup is `/api/rand?min=<int64>&max=<int64>`. This configuration uses path stripping Traefik middleware and a special Traefik ingress route to strip the `/api/` from the URL to forward those requests to the `demo-go-api` service. All other paths are routed to the `site` service running plain nginx using a standard Kubernetes ingress.

## Setup

You may want to [install the Traefik Helm chart](https://github.com/traefik/traefik-helm-chart/tree/master/traefik#installing) yourself. Otherwise the `deploy.sh` script will attempt to do it and then deploy all services in the cluster.

## Output

Once everything is deployed, Traefik routes from localhost:80.

Site:

```
> curl "http://localhost:80"
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

API (demo-go-api):

```
$ curl "http://localhost:80/api/rand?min=1&max=10"
{"result":4}
```
