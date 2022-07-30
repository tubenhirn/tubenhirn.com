---
title: "Automate dependency updates with dagger"
description: "automate project dependency updates with renovate and dagger and run it where ever you want"
date: "2022-07-26"
tags: ["dagger", "ci/cd", "renovate", "development", "cue", "docker"]
draft: true
---

Keeping project dependencies up-to-date is chore for every developer.\
`renovate` is a multi platform tool written in `Typescript` that let's you automated those update tasks.\
Combine `renovate` with `dagger` and you get a full managed CI/CD pipeline that updates all your dependencies.

### whats dagger

Dagger is a "portable devkit for CI/CD pipelines".\
(for more details check the docs here https://docs.dagger.io/1200/local-dev)

It uses docker to run portable job containers and is configured with `cue`.

I think it is the perfect match for developer task automation and it can be used in
almost every environment.

When you are used to CI/CD tools like `gitlab` or `github actions` you may be aware of the
try and error commit/push loops when developing new pipelines or jobs.

Dagger can be run on your local machine and speeds up the feedback cycle when developing new
stuff.

### install dagger (with `homebrew`)

{{< highlight bash >}}
brew tap dagger/tap
brew install dagger
{{< /highlight >}}

### whats renovate

Renovate is a multi platform dependency update tool written in `Typescript`.\
It is open source and provides a ton of features for many different languages.\
(for more details check the docs here https://docs.renovatebot.com/)

It can be run in many different ways. My preference is to use it as a docker container.\
You can easily get it from https://hub.docker.com/r/renovate/renovate in the `latest` version.

## how I use both tools together

### setup dagger

The first step is to initialize a new `dagger project`.

{{< highlight bash >}}
dagger project init
{{< /highlight >}}

This command creates a `cue.mod/` directory inside your project.\
This is where all the dagger files can be found.

Next step is to create a custom dagger pipeline.\
Create a new `*.cue` file - I like `ci.cue` for mine.\
In this file we put all our custom code that describes our jobs we want to run in this project.

{{< highlight bash >}}
touch ci.cue
{{< /highlight >}}

As said earlier, dagger uses `cue` (a JSON superset) to describe\
what to do.

Example:

{{< highlight json >}}
package ci

// import the required packages from dagger
import (
    "dagger.io/dagger"
)

// "Plan" contains our jobs
dagger.#Plan & {
    actions: {
        mycustomjob: {
        ... job here
        }
    }
}

{{< /highlight >}}

This job (if complete..) can now be run with

{{< highlight bash >}}
dagger do build
{{< /highlight >}}

Now we know how a dagger pipeline looks like,\
time to add our custom renovate job.

The first thing we need to run our job is a fresh image of `renovate`.
Dagger brings a package to handle `docker commands` with ease.

Lets import this package.

{{< highlight json >}}
package ci

// import the required packages from dagger
import (
    "dagger.io/dagger"
    "universe.dagger.io/docker"
)
{{< /highlight >}}

Now we can use `docker commands` like `docker pull` inside our pipeline.

We add a `renovate` job and pull the `:latest` image of `renovate`.\
Save it to the `_image` local job variable.

{{< highlight json >}}
...
actions: {
    renovate: {
        _image: docker.#Pull & {
            source: "renovate/renovate:latest"
        }
    }
}
...
{{< /highlight >}}

Now we got a image of renovate, time to use it.
Therefor we use `docker run` and hand over the `_image`.

Put it all together, an we got our first dagger pipeline.

{{< highlight json >}}
package ci

import (
    "dagger.io/dagger"
    "universe.dagger.io/docker"
)

actions: {
    renovate: {
        _image: docker.#Pull & {
            source: "renovate/renovate:latest"
        }
        docker.#Run & {
            input:  _image.output
        }
    }
}
{{< /highlight >}}

Now we can run a local instance of `renovate`.

{{< highlight bash >}}
dagger do renovate
{{< /highlight >}}

{{< alert >}}
To find out more about the `docker` package you can browse through the `cue-files`
inside your project directory.\
`./cue.mod/pkg/universe.dagger.io/docker`
{{< /alert >}}

### setup renovate

### run the renovate job

## used tools

- dagger (https://dagger.io)
- renovate (https://github.com/renovatebot/renovate)
- cue (https://cuelang.org)
- docker (https://www.docker.com)
- homebrew (https://brew.sh)
