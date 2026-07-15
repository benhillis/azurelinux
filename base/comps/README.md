# `base` components

The .toml files in this directory tree define the set of *components* that
make up the `base` sub-project of the distro.

* Most components that are imported "as-is" are listed in [`components.toml`](components.toml).
* Imported components that require further customization or configuration, as well as those
  defined via locally stored `.spec` files are placed under their own directories.

This directory structure is expected to evolve over time; the .toml files use `includes`
keys to ensure that they're all loaded appropriately by `azldev`.

## Test wiring

Component-local tests are declared in a sibling `*.tests.toml` file as
`[tests.X]` (or `[test-groups.X]` for a named bundle), and wired onto a
component via `tests.tests` in its `.comp.toml`:

```toml
tests.tests = [{ name = "some-test" }, { group = "some-group" }]
```

The `type` field on a `[tests.X]` entry selects the framework: `lisa`,
`pytest`, or `tmt`. **Only `lisa`-type tests are currently executed** — TEE
(`azl-testexecutionengine-service`) only knows how to generate and run LISA
runbooks. There is no tmt executor today, and pytest-type component tests
aren't picked up by any runner either (the pytest harness under
`base/images/tests/` only covers image-level checks).

`tmt` remains a valid `type` in the azldev schema so components can
document the test shape they'd use once tmt execution support lands, but
**do not wire a `tmt`-type test into a component's `tests.tests`** — doing
so reports coverage that never actually runs. Instead, leave the
`[tests.X]`/`[tests.X.tmt]` block commented out in the component's
`*.tests.toml` as a reference for future wiring. See
[`bash/bash.tests.toml`](bash/bash.tests.toml) for an example of this
pattern.
