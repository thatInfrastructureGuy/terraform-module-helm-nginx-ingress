//-----------------Nginx Helm Repo Location----------------
data "helm_repository" "stable" {
    name                     = "stable"
    url                      = "https://kubernetes-charts.storage.googleapis.com"
}

//-----------------Nginx Helm Configuration----------------
resource "helm_release" "nginx-ingress" {
  name                       = "${var.nginx_helm_release_name}"
  namespace                  = "${var.nginx_helm_namespace}"
  repository                 = "${data.helm_repository.stable.metadata.0.name}"
  chart                      = "nginx-ingress"
  version                    = "0.25.1"

  values                     = [ "${var.nginx_helm_values_file}" ]

  set {
    name                     = "controller.service.loadBalancerIP"
    value                    = "${var.load_balancer_ip}"
  }

}
