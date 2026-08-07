---
type: Playbook
title: Publish ripple-ark
description: Release contract for @celados/ripple-ark on npm.celados.com.
when: Changing the package version, release workflow, registry configuration, or publishing a release.
---

# Publish ripple-ark

The package version and GitHub release tag are a single contract: version `X.Y.Z`
is published only by release tag `vX.Y.Z`.

## Release

1. Update `package.json` and `CHANGELOG.md` together.
2. Run `bun run verify`; this includes typecheck, lint, format, tests, pack inspection, all-subpath
   compilation, and compound-component SSR.
3. Commit and push `main`, then publish the matching GitHub Release.
4. Verify the publish workflow and install the exact version in a clean consumer.

The workflow uses the organization `NPM_TOKEN` secret. Local registry credentials
live only in the ignored `.npmrc`; `.npmrc.ci` contains no token value.
