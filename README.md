# Bossjones Tap

## How do I install these formulae?

`brew install bossjones/tap/<formula>`

Or `brew tap bossjones/tap` and then `brew install <formula>`.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).


### Contrib

To enable hooks on existing repos run `pre-commit install` inside that repo

```sh
pre-commit install
```

Hooks using the standard pattern will automatically update the hooks to latest on commit
To bump manually before commit run `pre-commit autoupdate` inside the repo

```sh
pre-commit autoupdate
```

## Setting up the hooks in a new repo

- Add a `.pre-commit-config.yaml` at the top level of the repo, this file should contain a pointer to this repo and a list of all the hooks you want to run

```
repos:
-   repo: git@git.corp.adobe.com:adobe-platform/ethos-core-git-hooks.git
    # On first run pre-commit will complain about a moving reference and then replace rev with a specific commit sha
    rev: main
    hooks:
    -   id: pre-commit-helm-docs
```
