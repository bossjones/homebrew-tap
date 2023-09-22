## User Guide (Borrowed from: https://gitlab.com/morpheus.lab/homebrew/-/blob/main/README.md?ref_type=heads)
### Install Homebrew

[Homebrew](https://brew.sh/) is a free and open-source package manager for macOS that lets you easily install Libav and keep it up-to-date.

If not already done, install Homebrew first.

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

### Install Libav

#### 1. Tap

If you have never used Homebrew to install Libav before, add this Libav tap first:

    brew tap bossjones/tap

#### 2. Install

Simply install the latest version of Libav with:

    brew install Libav

And follow possibly emerging instructions from Homebrew.

#### 3. Launch

Start Libav from the command line by typing:

    Libav-gui

### Update Libav

First, update the formulae and Homebrew itself:

    brew update

Find out what is outdated with:

    brew outdated

Upgrade everything with:

    brew upgrade

Or upgrade only Libav with:

    brew upgrade Libav

More information about updating and, if desired, how to prevent Libav from being automatically updated by Homebrew, etc. can be found in the [Homebrew FAQ](https://docs.brew.sh/FAQ).

### Install Specific Version of Libav

To install a specific version of Libav, you can append the desired version number with ```@<VERSION>```:

    brew install Libav@<VERSION>

An example would be: ```brew install Libav@2.2.0b3```.

To list all versions available online, you can simply do a ```brew search```:

    brew search Libav

### Uninstall Libav

Delete Libav with:

    brew uninstall Libav

Forcibly remove Libav along with deleting all it's versions:

    brew uninstall --force Libav

## Maintainer Guidelines

### Create Tap

    brew tap-new bossjones/tap

### To add a new formula for `foo` version `2.3.4` from `$URL`

* read [the Formula Cookbook](https://docs.brew.sh/Formula-Cookbook) or: `brew create $URL` and make edits
* `brew install --build-from-source foo`
* `brew audit --new-formula foo`
* `git commit` with message formatted `foo 2.3.4 (new formula)`
* [open a pull request](https://brew.sh/2020/11/18/homebrew-tap-with-bottles-uploaded-to-github-releases/) and fix any failing tests

### Publish Automatically Built Bottles

When a pull request making changes to a formula (or formulae) becomes green (all checks passed), then you can publish the built bottles. To do so, label your PR as `pr-pull` and the workflow will be triggered.

### Get GitHub Workflows

The latest available GitHub workflows created with the [`brew tap-new`](https://docs.brew.sh/Manpage#tap-new-options-userrepo) command can be found in the Homebrew project under [`Homebrew/brew/Library/Homebrew/dev-cmd/tap-new.rb`](https://github.com/Homebrew/brew/blob/master/Library/Homebrew/dev-cmd/tap-new.rb). The two required GitHub workflow files `publish.yml` and `tests.yml` are embedded in `tap-new.rb` and should from time to time be copied from there and updated in the Libav tap.

Or you simply create a new tap with e.g.

    brew tap-new bossjones/tap-tap-new

and this way generate two new YAML files which can be taken directly from the corresponding subfolder of the tap (in this example `/opt/homebrew/Library/Taps/Libav-lab/homebrew-Libav-tap-new/.github/workflows`).

If the second method is used, delete the temporary tap with

    brew untap Libav-lab/homebrew-Libav-tap-new

afterwards.

See also the [Homebrew-Core Maintainer Guide](https://github.com/Homebrew/brew/blob/master/docs/Homebrew-homebrew-core-Maintainer-Guide.md).

### Add Locally Built Bottles

#### Generate Bottle

Prepare the formula for eventual bottling during installation, skipping any post-install steps:

    brew install --build-bottle Libav

Generate a bottle (binary package) from a formula that was installed with
`--build-bottle` and write bottle information to a JSON file:

    brew bottle --no-rebuild --json Libav

Now, add the new bottle block line to the formula, e.g.:

    sha256 arm64_monterey: "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef"

Additional Cellar parameters such as [`cellar: :any` or `cellar: :any_skip_relocation`](https://docs.brew.sh/Bottles#cellar-cellar) **must be omitted**, otherwise the GUI will crash on startup due to missing libraries such as *QtXml*.

Alternatively, merge the new bottle block line with the existing formula using the `brew bottle` command:

    brew bottle --merge Libav--<VERSION>.<OS>.bottle.json

Replace `<VERSION>` with the correct version number.

#### Upload Bottle to GitHub

Set GitHub credentials:

    export HOMEBREW_GITHUB_PACKAGES_USER=Libav-lab
    export HOMEBREW_GITHUB_PACKAGES_TOKEN=<YOUR_PERSONAL_ACCESS_TOKEN>

Add bottle to release tag:

    brew pr-upload --upload-only --root-url="https://github.com/Libav-lab/homebrew-Libav/releases/download/Libav-VERSION"

Or upload bottle to GitHub Packages (Docker):

    brew pr-upload --upload-only --root-url="https://ghcr.io/v2/Libav-lab/homebrew"

#### Check & Commit

Check formula for Homebrew coding style violations:

    brew audit Libav

Or check the whole tap:

    brew audit --tap bossjones/tap

If necessary, let `brew` fix them automatically:

    brew audit --fix Libav

Check formulae for conformance to Homebrew style guidelines:

    brew style bossjones/tap

Fix style violations automatically using:

    brew style --fix bossjones/tap

Commit and push the updated bottle block for the formula. Provide a commit message in the style of:

    git commit -m "Libav: add <VERSION> bottle (<OS/ARCHITECTURE>)"

Replace `<VERSION>` and `<OS/ARCHITECTURE>` with the corresponding values.
