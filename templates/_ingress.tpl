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
    {{- include "ingress-example.labels" $.g | nindent 4 }}
  annotations:
    {{- include "ingress-example.annotations" . | indent 4 }}
spec:
  rules:
    - host: {{ $.g.Values.ingress.host }}
      http:
        paths:
          {{- if and (eq $.g.Values.ingress.controller "kubernetes-nginx") (ne .service.prefix "/") }}
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
  {{- $.g.Values.ingress.tls | toYaml | nindent 4 }}
{{- end }}

