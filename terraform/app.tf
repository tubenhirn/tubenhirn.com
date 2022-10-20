resource "digitalocean_app" "tubenhirn-com" {
  spec {
    # general app settings
    name   = var.APP_NAME
    region = var.REGION

    # domain settings
    domain {
      name = var.APP_DOMAIN
      type = var.APP_DOMAIN_TYPE
      zone = var.APP_DOMAIN_ZONE
    }

    # tubenhirn.com static hugo page
    static_site {
      name             = var.APP_NAME
      build_command    = "hugo -d public"
      environment_slug = "hugo"

      github {
        repo           = "tubenhirn/tubenhirn.com"
        branch         = "main"
        deploy_on_push = true
      }

      routes {
        path                 = "/"
        preserve_path_prefix = false
      }
    }
  }
}
