local prometheus = import 'prometheus-ksonnet/prometheus-ksonnet.libsonnet';

prometheus
{
  local service = $.core.v1.service,

  _config+:: {
    namespace: 'default',
    cluster_name: 'default',
  },

  _images+:: {
    grafana: 'grafana/grafana:6.6.1',
  },

  main_prometheus+: {
    prometheus_container+::
      $.util.resourcesRequests('250m', '500Mi'),
  },

  nginx_service+:
    service.mixin.spec.withType('ClusterIP') +
    service.mixin.spec.withPorts({
      port: 80,
      targetPort: 80,
    }),

  local ingress = $.extensions.v1beta1.ingress,
  ingress: ingress.new() +
           ingress.mixin.metadata.withName('ingress')
           + ingress.mixin.metadata.withAnnotationsMixin({
             'ingress.kubernetes.io/ssl-redirect': 'false',
           })
           + ingress.mixin.spec.withRules([
             ingress.mixin.specType.rulesType.mixin.http.withPaths(
               ingress.mixin.spec.rulesType.mixin.httpType.pathsType.withPath('/') +
               ingress.mixin.specType.mixin.backend.withServiceName('nginx') +
               ingress.mixin.specType.mixin.backend.withServicePort(80)
             ),
           ]),
}
