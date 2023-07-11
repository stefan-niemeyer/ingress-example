{{/*
Ingress annotations
*/}}
{{- define "ingress-example.annotations" -}}
{{- if eq .global.Values.ingress.controller "traefik" }}
traefik.ingress.kubernetes.io/router.middlewares: {{ .global.Release.Namespace }}-ingress-example-stripprefix@kubernetescrd
{{- else if eq .global.Values.ingress.controller "nginx" }}
nginx.org/rewrites: "serviceName={{ .service.serviceName }} rewrite=/"
{{- else if eq .global.Values.ingress.controller "kubernetes-nginx" }}
nginx.ingress.kubernetes.io/use-regex: "true"
nginx.ingress.kubernetes.io/rewrite-target: /$2
nginx.ingress.kubernetes.io/x-forwarded-prefix: {{ .service.prefix}}
{{- else if eq .global.Values.ingress.controller "haproxy-openshift" }}
haproxy.router.openshift.io/rewrite-target: "/"
{{- else }}
{}
{{- end }}
{{- end }}
