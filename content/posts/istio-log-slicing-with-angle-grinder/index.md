---
title: "Istio log slicing with angle-grinder"
description: "slice and dice istio logs with stern and angle-grinder"
date: "2022-05-31"
tags: ["istio", "logging", "shell"]
---

For me `angle-grinder` is a handy tool when it comes to `istio` log-analysis.\
I love the combindation of `stern` and `angle-grinder` to gain an quick overview how `istio-ingressgateway` is doing.

I'll give you a short overview of statements I use often.

{{< alert >}}
the given examples filter all stern results for `start_time` to drop unnecessary logs
you can also use `agrind '* | ...'`
{{< /alert >}}

### ingress logs, p95 and max for upstream_service_time, grouped by path

{{< highlight bash >}}
stern istio-ingressgateway -o raw -n istio-system \
    | agrind 'start_time | json
    | count, p95(upstream_service_time), max(upstream_service_time)
    by path'
{{< /highlight >}}

### ingress logs, filtered for response_code 5xx, grouped by response_code

{{< highlight bash >}}
stern istio-ingressgateway -o raw -n istio-system \
    | agrind 'start_time | json
    | where response_code > 499
    | count, p95(upstream_service_time), max(upstream_service_time)
    by response_code'
{{< /highlight >}}

### ingress logs, grouped by user_agent and authority

{{< highlight bash >}}
stern istio-ingressgateway -o raw -n istio-system \
    | agrind 'start_time | json
    | count
    by user_agent, authority'
{{< /highlight >}}

### ingress logs, filtered by authority, grouped by user_agent

{{< highlight bash >}}
stern istio-ingressgateway -o raw -n istio-system \
    | agrind 'start_time | json
    | where authority == "tubenhirn.com"
    | count
    by user_agent'
{{< /highlight >}}

### istiod logs, grouped by level

{{< highlight bash >}}
stern istiod -o raw -n istio-system \
    | agrind '* | json
    | count
    by level'
{{< /highlight >}}

## used tools

- angle-grinder (https://github.com/rcoh/angle-grinder)
- stern (https://github.com/stern/stern)
- istio (https://istio.io/)

