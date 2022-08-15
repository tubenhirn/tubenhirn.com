---
title: "Scheduled lighthouse testing"
description: "Use scheduled Gitlab pipelines to trigger lighthouse performance tests"
tags: ["test", "lighthouse", "ci/cd", "cloud-sql", "gcp", "performance", "gitlab-ci", "k8s"]
date : "2021-12-01"
author: "jstang"
draft: true
---

Using lighthouse-ci together with Gitlab pipelines and custom Kubernetes runners
to be able to test every feature-branch of an given application.

The constant flow of changes and new features has an hughe impact on the measured
performance-index sometimes. So testing a feature-branch early, gives you a good insight
on how the changes will impact on the overall score.

You can modify your code again, making crucial modifications or small tweaks
before the new feature gets shipped to the customer.

---

## used tools and technologies

- Gitlab-CI
- Google Kubernetes Engine
- Google Cloud SQL
- Lighthouse-CI

