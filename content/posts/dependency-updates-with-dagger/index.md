---
title: "Automate dependency updates with dagger"
description: "automate project dependency updates with renovate and dagger and run it where ever you want"
date: "2022-07-26"
tags: ["dagger", "ci/cd", "renovate", "development", "cue", "docker"]
draft: false
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
(for more details check the docs here https://docs.renovatebot.com)

It can be run in many different ways. My preference is to use it as a docker container.\
You can easily get it from https://hub.docker.com/r/renovate/renovate in the `latest` version.

## how I use both tools together

### setup renovate

To setup `renovate` we need to add a `renovate` configuration file to our project.

I prefer a json file named `renovate.json`. 

{{< highlight bash >}}
touch renovate.json
{{< /highlight >}}

#### A basic configuration example

{{< highlight json >}}
{
    "$schema": "https://docs.renovatebot.com/renovate-schema.json",
    // the projects default branch we want our updates on
    "baseBranches": ["main"],
    "extends": [
        // the basic renovate config template
        "config:base", 
        // I like semantic commits
        ":semanticCommits", 
        // I dont use the dependency dashboard
        ":disableDependencyDashboard"
    ],
    // tell renovate to ignore the dagger folder
    "ignorePaths": ["**/cue.mod/**"]
}
{{< /highlight >}}

{{< alert >}}
`renovate` accepts a wide range of configuration methods.
Check the docs for more details https://docs.renovatebot.com/configuration-options/#configuration-options
{{< /alert >}}

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

To tell `renovate` what to do, we need to pass a few configuration values to the container before we can run it.

`Dagger` is able to read different types of values from the current `client` it is running on.
This feature we can use to pass values like an `authToken` or other sensible data to the container.

To read client `environment` variables you only need to export them.

{{< highlight bash >}}
export GITLAB_TOKEN=<GITLAB_API_TOKEN>
export GITHUB_TOKEN=<GITHUB_API_TOKEN>
{{< /highlight >}}

Once done, we can read them with `dagger`.

{{< highlight json >}}
dagger.#Plan & {
    client: env: {
        GITLAB_TOKEN: dagger.#Secret
        GITHUB_TOKEN: dagger.#Secret
    }
    ...
}
{{< /highlight >}}

Put it all together, an we got our first dagger pipeline.

{{< highlight json >}}
package ci

import (
    "dagger.io/dagger"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    client: env: {
        GITLAB_TOKEN: dagger.#Secret
        GITHUB_TOKEN: dagger.#Secret
    }
    actions: {
        renovate: {
            _image: docker.#Pull & {
                source: "renovate/renovate:latest"
            }
            docker.#Run & {
            input:  _image.output
                env: {
                    // the access-token to access our project (gitlab project here)
                    RENOVATE_TOKEN:                 client.env.GITLAB_TOKEN
                    // a github access-token to access package updates and CHANGELOG on github
                    GITHUB_COM_TOKEN:               client.env.GITHUB_TOKEN
                    // tell renovate where your project is hostes (gitlab, github, bitbucket)
                    RENOVATE_PLATFORM:              "gitlab"
                    // the path of your project
                    RENOVATE_REPOSITORIES:          "my/gitlab/projectpath"
                }
            }
        }
    }
}
{{< /highlight >}}

{{< alert >}}
To find out more about `RENOVATE_PLATFORM` and `RENOVATE_REPOSITORIES` check out the documentation
https://docs.renovatebot.com

To find out more about the `docker` package you can browse through the `cue-files`
inside your project directory.\
`./cue.mod/pkg/universe.dagger.io/docker`
{{< /alert >}}

### run renovate the first time

Once we are finished with our new pipeline we have to download all the dependencies we defined
inside the `import` statements.

{{< highlight bash >}}
dagger project update
{{< /highlight >}}

Now we can run a local instance of `renovate`.

{{< highlight bash >}}
dagger do renovate
{{< /highlight >}}

## used tools

- dagger (https://dagger.io)
- renovate (https://github.com/renovatebot/renovate)
- cue (https://cuelang.org)
- docker (https://www.docker.com)
- homebrew (https://brew.sh)
