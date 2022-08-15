package ci

import (
	"strings"
	"dagger.io/dagger"
	"dagger.io/dagger/core"

	"universe.dagger.io/x/ezequiel@foncubierta.com/terraform"
)

dagger.#Plan & {
	client: filesystem: ".": read: contents: dagger.#FS
	client: env: {
		ACCESS_TOKEN: dagger.#Secret
	}

	actions: {
		_source: client.filesystem["."].read.contents
		_versionString: {
			_version: core.#ReadFile & {
				input: _source
				path:  "version"
			}
			output: strings.TrimSpace(_version.contents)
		}

		"deploy": {
			_tfenv: {
				TF_VAR_ACCESS_TOKEN: client.env.ACCESS_TOKEN
			}
			_tfSource: core.#Source & {
				path: "./terraform"
			}
			init: terraform.#Init & {
				source: _tfSource.output
			}
			validate: terraform.#Validate & {
				source: init.output
			}
			plan: terraform.#Plan & {
				source: validate.output
				cmdArgs: ["--var-file=live.tfvars"]
				env: _tfenv
			}
			apply: terraform.#Apply & {
				source: plan.output
				env:    _tfenv
			}
		}
	}
}
