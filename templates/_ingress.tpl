{{/*
Ingress definition
*/}}
{{- define "ingress-example.ingress" -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .key }}-ingress
  labels:
    {{- include "ingress-example.labels" $.global | nindent 4 }}
  annotations:
    {{- include "ingress-example.annotations" (dict "global" $.global "service" $.service) | indent 4 }}
spec:
  rules:
    - host: {{ $.global.Values.ingress.host }}
      http:
        paths:
          {{- if and (eq $.global.Values.ingress.controller "kubernetes-nginx") (ne .service.prefix "/") }}
          - path: "{{ .service.prefix }}(/|$)(.*)"
            pathType: "Prefix"
            backend:
              service:
                name: {{ $.key }}
                port:
                  name: http
          {{- end }}
          - path: {{ .service.prefix | quote }}
            pathType: "Prefix"
            backend:
              service:
                name: {{ $.key }}
                port:
                  name: http
  tls:
  {{- $.global.Values.ingress.tls | toYaml | nindent 4 }}
{{- end }}

