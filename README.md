# AOC 2022 using CL and Nix

Usage:

```
nix run . -- day1 (args..)
```

Or to run without cloning:

```
nix run github:hraban/aoc-2022-cl-nix -- dayN (args..)
```

The Lisp system is called `aoc-2022x` because both ASDF and Nix get confused by a system name ending in a number. Nix thinks it’s a version part and strips it off entirely, and ASDF has a weird error with transitive includes using `package-inferred-system`.
