# ingress-example

This is an example of how to create ingresses for different ingress controllers with simple web applications.

The `base` web application is a NGINX server that returns a page with links to other NGINX applications. They all share the same domain name, but are separated by different paths.

## Namespace creation
If you want to install the chart in a new namespace, you have to create it first. This can be done with the following command:
```bash
kubectl apply -f namespace.yaml
```
This will create a namespace called `ingress-example`, and can of course be changed to your liking.

## Domain configuration
This repository uses the domain `laserschwert.io`. The corresponding wildcard certificate needs to be installed as a secret in the namespace, where the ingresses are installed. The name of the secret needs to be `laserschwert-io-tls`.

This configuration can be adopted. Just have a look at the entries under `ingress` in the `values.yaml` file.

## Availabe Ingresses
The following ingresses are created:

| Path     | Application                                   |
|----------|-----------------------------------------------|
| base     | https://ingress-example.laserschwert.io             |
| red      | https://ingress-example.laserschwert.io/red         |
| orange   | https://ingress-example.laserschwert.io/orange      |
| yellow   | https://greengreen.laserschwert.io/yellow |
| echo     | https://greengreen.laserschwert.io/echo       |

The ingress controllers are configured to route the traffic to the correct service based on the path and strip the first part of the path from the request. This is done by annotations in the ingress definition.

The link in the square named LOCAL redirects to `/base-blue` and ends up at the `base` application because there is no special ingress for that path. 

# Supported ingress controllers
This repositroy supports the following ingress controllers:
- [Traefik](https://traefik.io/)
- [NGINX Ingress Controller](https://docs.nginx.com/nginx-ingress-controller/)
- [Kubernets Ingress-Nginx Controller](https://kubernetes.github.io/ingress-nginx/)
- [HAProxy Ingress Controller](https://haproxy-ingress.github.io/)
