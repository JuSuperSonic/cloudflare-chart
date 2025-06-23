{{/*
Expand the name of the chart.
*/}}
{{- define "cloudflare-tunnel.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cloudflare-tunnel.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cloudflare-tunnel.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "cloudflare-tunnel.labels" -}}
helm.sh/chart: {{ include "cloudflare-tunnel.chart" . }}
{{ include "cloudflare-tunnel.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "cloudflare-tunnel.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cloudflare-tunnel.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Check configuration about local or remote mode.
*/}}
{{- define "cloudflare-tunnel.validateTunnelConfig" -}}
{{- if and (eq .Values.configurationSource "local") (not .Values.local.secretName) }}
    {{- if not .Values.local.accountId }}
      {{- fail "accountId must be set when configurationSource is 'local'" }}
    {{- end }}
    {{- if not .Values.local.tunnelId }}
      {{- fail "tunnelId must be set when configurationSource is 'local'" }}
    {{- end }}
    {{- if not .Values.local.tunnelSecret }}
      {{- fail "tunnelSecret must be set when configurationSource is 'local'" }}
    {{- end }}
{{- else if and (eq .Values.configurationSource "remote") (not .Values.remote.secretName) }}
    {{- if not .Values.remote.tunnelToken }}
      {{- fail "tunnelToken must be set when configurationSource is 'remote'" }}
    {{- end }}
{{- end }}
{{- end }}

{{/*
Warning about ingress redirection.
*/}}
{{- define "cloudflare-tunnel.warning.empty.ingress" -}}
{{- if and (eq .Values.configurationSource "local") (hasKey .Values.local "ingress") }}
  {{- if eq (len .Values.local.ingress) 0 }}
    {{- printf "WARNING: The 'ingress' array is empty : No hostname linked to Kubernetes service or host." }}
  {{- end }}
{{- end }}
{{- end }}
