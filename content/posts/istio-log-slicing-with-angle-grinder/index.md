---
title: "Istio log slicing with angle-grinder"
description: "slice and dice istio logs with stern and angle-grinder"
date: "2022-05-31"
tags: ["istio", "logging", "shell"]
---

For me `angle-grinder` is a handy tool when it comes to `istio` log-analysis.\
I love the combindation of `stern` and `angle-grinder` to gain an quick overview how `istio-ingressgateway` is doing.

I'll give you a short overview of statements I use often.

### calculate the p95 and max for upstream_service_time, group the lines by path

{{< highlight bash >}}
stern istio-ingressgateway -o raw -n istio-system \
    | agrind 'start_time | json
    | count, p95(upstream_service_time), max(upstream_service_time)
    by path'
{{< /highlight >}}

### filter for response_code 5xx, group lines by response_code

{{< highlight bash >}}
stern istio-ingressgateway -o raw -n istio-system \
    | agrind 'start_time | json
    | where response_code > 499
    | count, p95(upstream_service_time), max(upstream_service_time)
    by response_code'
{{< /highlight >}}

### count all requests, group by user_agent and authority

{{< highlight bash >}}
stern istio-ingressgateway -o raw -n istio-system \
    | agrind 'start_time | json
    | count
    by user_agent, authority'
{{< /highlight >}}

## used tools

- angle-grinder (https://github.com/rcoh/angle-grinder)
- stern (https://github.com/stern/stern)
- istio (https://istio.io/)

