---
title: "dagger revisited - golang sdk"
description: "take a look at dagger and rework some old code."
date: "2023-03-30"
tags: ["dagger", "ci/cd", "development", "golang"]
draft: true
showTableOfContents: false
---

A few month ago I discovered `dagger` (https://docs.dagger.io/).\
I decided to build my `renovate` jobs with it.

A lot of cool new features has been added to `dagger` since then and I think it is time to take a deeper look.

### whats new

When I gave `dagger` a first shot the only possible language for writing `dagger`-pipelines was `cue` (https://cuelang.org).

This has changed now - `dagger` now offers a whide range of sdk's for different languages.

 - https://docs.dagger.io/sdk/go
 - https://docs.dagger.io/sdk/nodejs
 - https://docs.dagger.io/sdk/python
 - https://docs.dagger.io/sdk/cue
 - https://docs.dagger.io/api
 - https://docs.dagger.io/cli
 
### install dagger go-sdk
