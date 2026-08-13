# JessamineCLI

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://wgmitchener.github.io/JessamineCLI.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://wgmitchener.github.io/JessamineCLI.jl/dev/)
[![Build Status](https://github.com/wgmitchener/JessamineCLI.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/wgmitchener/JessamineCLI.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Aqua QA](https://juliatesting.github.io/Aqua.jl/dev/assets/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

## Overview

This package holds a command-line interface (CLI) to the [Jessamine.jl](https://github.com/wgm-applied-math/Jessamine.jl) symbolic regression package.

Just so you know:
Jessamine and this CLI are under development.
Symbolic regression is a complicated calculation with a _lot_ of configuration options and it is not easy to use.

To make the package available in a Julia project environment:
- Start a project
- Start a Julia command line and activate the project
- Type `]` to go to the package interface
- Then run
```
add https://github.com/wgm-applied-math/JessamineCLI.jl#main
```


## `AppSimple`

Once you install this package, the `AppSimple` executable main script can be run as
```bash
julia --project=@. -q -m JessamineCLI.AppSimple -- arguments...
```
By the way, the `--project=@.` means to use the project holding the current directory.
The `-q` makes Julia quiet, so it displays fewer messages as it starts up.
The `-m` specifies the module containing a `main()` function.
The `--` means that all following arguments are passed to the `main()` function via the global variable `ARGS`.
Modify as needed for your situation.


The `arguments` should be
- a command, either `setup_samples` or `sr`
- flags and such

Flags and options given on the command line are in kebab case, as in `--lambda-op 1e-10` or `--lambda-op=1e-10`.

Options can also be put in a config file in TOML format, in which they are in snake_case, as in `lambda_op = 1e-10`.
Give `--config-file MY_CONFIG_FILE.toml` as a command line option to load a config file.
Currently, config files can't load other config files.
But you can give `--config-file ...` more than once on the command line and all of the files are read in order.

### Command `setup_samples`

Create a bunch of spec files in TOML format with options for the `sr` command.
Give the `--help` option to see all available options,
```bash
julia --project=@. -q -m JessamineCLI.AppSimple -- setup_samples --help
```

To give an example,
```bash
julia --project=@. -q -m JessamineCLI.AppSimple -- \
    setup_samples \
    --config-file baseline.toml \
    --config-file extra-generations.toml \
    --config-path-template "Specs/some-data-%03d.toml" \
    --sr-output-dir "Generated/some-data/" \
    --num-samples 25 \
    --data-file "datasets/some-data.csv"
```
This will load configuration from `baseline.toml` and `extra-generations.toml`.
It will create a bunch of files named `Specs/some-data-001.toml`, `Specs/some-data-002.toml` etc. up to `Specs/some-data-025.toml`
The `--num-samples` option sets the number of files to create.
The `--config-path-template` option is a string with a printf-style `%d` pattern which will be replaced with the sample number.
The `--sr-output-dir` option makes lines like these in the resulting TOML files:
```toml
log_file = "Generated/some-data/001/log.txt"
output_file_stem = "Generated/some-data/001/result"
progress_file_stem = "Generated/some-data/001/progress"
```
Options for the `sr` command may be included.
The `--data-file` option puts this line in the resulting TOML files:
```toml
data_file = "datasets/some-data.csv"
```

The `random_state` setting is used by `sr` to seed a random number generator and pull a distinct seed for each resulting TOML file:
```toml
random_state = 0x5f7a8c3f937ff2b4
```

You can also include any options available to the `sr`.
These will be included in the resulting TOML files.

### Command `sr`

Perform symbolic regression.
Give the `--help` option to see all available options,
```bash
julia --project=@. -q -m JessamineCLI.AppSimple -- sr --help
```

My normal practice is to put most of the options into a TOML file,
then use the `setup_samples` command to make a bunch of spec files,
each with its own sample number as part of various file names, and its own random seed.
Then run a sample by passing the path to the config file
```bash
julia --project=@. -q -m JessamineCLI.AppSimple -- sr --config-file Specs/some-data-001.toml
```

The complete set of options for `sr` is very long and requires an understanding of how Jessamine works.
A research article with this information is in preparation.

### Running on a Slurm cluster

The Jessamine symbolic regression system is generally run many times over minutes or hours.
For examples of running it on a Slurm cluster, see [JessamineBenchmark.jl](https://github.com/wgm-applied-math/JessamineBenchmark.jl).

### Installing as an app

You may also install this package as an app so that `AppSimple` will run as
```bash
jessamine argument...
```
To do so, go to the Julia package interface and run
```
app add https://github.com/wgm-applied-math/JessamineCLI.jl#main
```
That command will add a file `~/.julia/bin/jessamine` to run `AppSimple` directly.
