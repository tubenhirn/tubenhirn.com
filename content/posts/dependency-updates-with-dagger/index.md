---
title: "automate dependency updates with dagger"
description: "automate project dependency updates with renovate and dagger"
date: "2022-07-26"
tags: ["dagger", "ci/cd", "renovate", "dev"]
draft: "true"
---

Keeping project dependencies up-to-date is chore for every developer.\
`renovate` is a multi platform tool written in `Typescript` that let's you automated those update tasks.\
Combine `renovate` with `dagger` and you get a full managed CI/CD pipeline that updates all your dependencies.

### whats dagger

Dagger is a "portable devkit for CI/CD pipelines".\
(for more details check the docs here https://docs.dagger.io/1200/local-dev)

## used tools

- dagger (https://dagger.io/)
- renovate (https://github.com/renovatebot/renovate)

