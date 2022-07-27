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

It uses docker to run portable job containers and is configured with cuelang.

For me it is the perfect match for developer task automation and it can be used in\
almost every environment.

### whats renovate

Renovate is a multi platform dependency update tool written in `Typescript`.\
It is open source and provides a ton of features for many different languages.\
(for more details check the docs here https://docs.renovatebot.com/)

It can be run in many different ways. My preference is to use it as a docker container.\
You can easily get it from dockerhub in the latest version.

## how I use both tools together


## used tools

- dagger (https://dagger.io/)
- renovate (https://github.com/renovatebot/renovate)

