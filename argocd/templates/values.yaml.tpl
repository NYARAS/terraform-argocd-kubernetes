global:
  domain: ${hostname}
  deploymentStrategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%

controller:
  resources:
   limits:
     cpu: 1000m
     memory: 1024Mi
   requests:
     cpu: 250m
     memory: 256Mi
  metrics:
    enabled: true
    serviceMonitor:
      enabled: true
      additionalLabels:
        release: "prometheus-operator"
  podAnnotations:
    co.elastic.logs/enabled: "true"

repoServer:
  metrics:
    enabled: true
    serviceMonitor:
      enabled: true
  autoscaling:
    enabled: ${autoscaling_enabled}
  podAnnotations:
    co.elastic.logs/enabled: "true"

configs:
  rbac:
    create: true
    policy.csv: |
      p, role:readonly, applications, get, */*, allow
      p, role:readonly, certificates, get, *, allow
      p, role:readonly, clusters, get, *, allow
      p, role:readonly, repositories, get, *, allow
      p, role:readonly, projects, get, *, allow
      p, role:readonly, accounts, get, *, allow
      p, role:readonly, gpgkeys, get, *, allow
      p, role:readonly, logs, get, */*, allow
      g, qa, role:readonly

server:
  config:
    accounts.admin: apiKey   #login is available as default on admin user
    accounts.qa: apiKey,login
  service:
    type: NodePort
    nodePortHttp: 30080
    nodePortHttps: 30443
  extraArgs:
   - --insecure
  resources:
   limits:
     cpu: 200m
     memory: 300Mi
   requests:
     cpu: 100m
     memory: 150Mi
  metrics:
    enabled: true
    serviceMonitor:
      enabled: true
      additionalLabels:
        release: "prometheus-operator"
  autoscaling:
    enabled: ${autoscaling_enabled}
  # Argo CD server ingress configuration
  ingress:
    enabled: true
    annotations:
      cert-manager.io/cluster-issuer: ${issuer_name}
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    ingressClassName: ${ingress_class_name}
    hostname: ${hostname}
    path: /
    pathType: Prefix
    tls: true
  podAnnotations:
    co.elastic.logs/enabled: "true"

redis:
  enabled: true
  resources:
   limits:
     cpu: 500m
     memory: 750Mi
   requests:
     cpu: 100m
     memory: 150Mi
  metrics:
    enabled: true
    serviceMonitor:
      enabled: true
      additionalLabels:
        release: "prometheus-operator"
  podAnnotations:
    co.elastic.logs/enabled: "true"

redis-ha:
  enabled: ${redis_ha_enable}
  exporter:
    enabled: true
