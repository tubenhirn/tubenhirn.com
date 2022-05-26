---
title: "testing with locust"
description: "testing web-app response time with locust and pushing the results to bigquery"
tags: ["locust", "k8s", "load-testing", "performance", "test", "python", "gcp", "google-cloud", "bigquery"]
date : "2022-05-26"
---

As a dev-team, we wanted to know how good our new application is doing under load and how changes to the code-base
or the infrastructure affects the response time.

We decided to look out for a load-testing solution that was able to create a high amount of load when we need it.
Our research brought us to https://locust.io/ and it looked like a promising candidate.

We set up a k8s-cluster with terraform and threw in a controller- and a bunch of worker-deployments of locust.
Locust makes it easy to record a test profile with your browser and use it with the controller later on.

When the tests are finished you can export a result in different file formats. We decided to go for *.csv*.

The next step was to put the results in a time series.

We created a Big-Query dataset that represents the load-test result.
A Cloud-Function is used to import the results into the dataset so we can use them for our review.

Last was a report made with Data-Studio that is linked to the dataset in Big-Query.
This report updates every time a new result was pushed to the dataset.

Put that all together we got a pretty nice solution that let us keep an eye on the performance of our application
while it is under constant development.

{{< mermaid >}}
graph LR;
A[Locust]-->B[Google-Bucket];
B-->C[Big-Query]
C-->D[Data-Studio]
{{< /mermaid >}}

## used tools and technologies

- google cloud platform
- BigQuery
- Google Data Studio
- Google Kubernetes Engine
- Google CloudFunctions
- Locust (https://locust.io/)
- Terraform
