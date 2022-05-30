---
title: "delivery automation with keptn"
description: "delivery process with automated quality gates by keptn"
date: "2022-05-30"
tags: ["gitlab-ci", "keptn", "ci/cd", "k8s", "gcp"]
---

## context

As a developer I want my applications deployment to be as easy as possible.
Rolling out new features and bugfixes should not scare me.
Testing (in prod) should not work against a high quality customer experience.
Rolling back a new version should be as easy as the rollout.

Extending an API or fixing a bug in a service can have a hughe impact on your applications response time.
To keep track of the applications performance and stop those releases from being shipped to the customer
an early measuring and checking mechanism is required.

Keptn offers automated quality gates based on self defined SLI's and SLO'S.
It is capable of testing your new releases before they are made available for your customers.
Equipped with and extendable API it can connect to many existing tools (e.g. gitlab-ci or argoCD).

In our case we used Apache JMeter and Lighthouse-CI from Google to test the applications API and react-frontend.
Defined SLI's (size of js-bundles, response-time, lighthouse score) where matched against our SLO's.
If a new version fails those quality gates, the rollout is stopped and the team notified.

## what we did

- First of install keptn into your k8s-cluster.
- Configure a new project in Gitlab that holds the desired configuration for your different environements.
- Add your applications Helm-Charts that are used by keptn to apply your applicaiton-code to the cluster.
- Next you define your desired SLI's (for example Response-Time).
- Setup a test-step (e.g. JMeter-Test against the applications API or Google Lighthouse against your frontend).
- Define a SLO based on your SLI and let keptn check if the deployed version of your application matches it.

## used tools and technologies

- keptn (https://keptn.sh)
- Apache JMeter
- Google Lighthouse
- Googel Kubernetes Engine


