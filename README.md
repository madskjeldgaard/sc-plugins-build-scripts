# MacOS plugin build scripts

# Usage:

First get this repo:

```bash 
git clone --recurse-submodule https://github.com/madskjeldgaard/sc-plugins-build-scripts
cd sc-plugins-build-scripts
```

Then run one of the build scripts like so to build and install a plugin package:

```bash 
./guttersynth-sc x86_64
```

As you can see, the frst argumement is the target architecture. `x86_64` is used if you run SC on an intel based mac or if you have SuperCollider installed under Rosetta on an M1-based mac. Otherwise use `arm64`.
