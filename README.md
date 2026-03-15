![Cloudflare Logo](https://cf-assets.www.cloudflare.com/slt3lc6tev37/fdh7MDcUlyADCr49kuUs2/5f780ced9677a05d52b05605be88bc6f/cf-logo-v-rgb.png?_gl=1*wbg9h0*_gcl_au*MTYwNDEzMzA3Ny4xNzQxNzA4MTI3*_ga*Yzc0MjRlNzgtM2Q5Ny00OWJhLWEyZTEtYWE4ZWUyMzE4MmE1*_ga_SQCRB0TXZW*czE3NDgzMzU2NjYkbzEyJGcwJHQxNzQ4MzM1NjY3JGo1OSRsMCRoMCRkTkhydnFqRVZfYnNjeTV6SE9TbnRwSjVmTktPSDRqQVRpdw.. "Cloudflare")

# Description

This is a Helm chart for deploying [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/) (via `cloudflared`) into your Kubernetes cluster.

Cloudflared enables secure, outbound-only connections from your cluster to Cloudflare’s edge network — no need to expose ports.

This chart supports both **remote-managed tunnels** (configured via the Cloudflare dashboard) and **locally-managed tunnels** (configured via a `config.yaml` file).


# Configuration

With Cloudflared you can handle configuration in two way.

## Remote configuration

The configuration is managed from Cloudflare’s dashboard.
You define tunnels, ingress rules, and other settings directly on their side.
No config file is needed in your container or pod. It just connects using the `tunnelToken`.

## Local configuration

Your configuration is inside this deployment.
You have to configure Cloudflare in order to create DNS, Cloudflare Tunnel mange by this chart.
This approach is use generaly if cloudflare is configure with IaC or API.

# Installation

Apply chart into Kubernetes in Remote configuration :

```bash
export tunnelToken=<my_token_get_from_tunnel_creation> # https://one.dash.cloudflare.com/<my_account_id>/networks/tunnels/new

helm upgrade --install my-release . --set remote.tunnelToken="${tunnelToken}"
```
