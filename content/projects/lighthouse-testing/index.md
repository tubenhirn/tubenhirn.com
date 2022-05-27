---
title: "Scheduled lighthouse testing"
description: "Use scheduled Gitlab pipelines to trigger lighthouse performance tests"
tags: ["test", "lighthouse", "ci/cd", "cloud-sql", "gcp", "performance", "gitlab.com", "k8s"]
date : "2022-05-26"
---

Using lighthouse-ci together with Gitlab pipelines and custom Kubernetes runners
to be able to track every single feature-branch of an given application.

The constant flow of changes and new features has an impact on the measured
performance-index.

Testing a feature-branch early gives you a good insight on how the changes will impact the overall 
score and making crucial changes before the new feature gets shipped to the customer.

## used tools and technologies

- Gitlab-CI
- Google Kubernetes Engine
- Google Cloud SQL
- Lighthouse-CI

