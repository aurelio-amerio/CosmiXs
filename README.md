![alt text](http://github.com/ajueid/DMSpectra/blob/main/img/Logo.png?raw=true)

# CosmiXs: Cosmic messenger spectra for indirect dark matter searches 
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://aurelio-amerio.github.io/CosmiXs.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://aurelio-amerio.github.io/CosmiXs.jl/dev/)
[![Build Status](https://github.com/aurelio-amerio/CosmiXs.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/aurelio-amerio/CosmiXs.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/aurelio-amerio/CosmiXs.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/aurelio-amerio/CosmiXs.jl)

Julia implementation for https://arxiv.org/abs/2312.01153 derived from https://github.com/ajueid/CosmiXs. All credits go to the original authors.

## Installation

```julia
using Pkg
Pkg.add("https://github.com/aurelio-amerio/CosmiXs.jl.git")
```

## Usage

This library implements the dNdE function from the original paper.

`dNdE(mDM::Energy, K::Energy; final_particles="Gammas", primary_channel="b")`

Returns the differential flux of `final_particles` from the annihilation of dark matter into `primary_channel` particles, 
given the energy of final particles `K` and the dark matter mass `mDM`.

Available `final_particles` are: `AntiProtons`, `Gammas`, `NuEl`, `NuMu`, `NuTau`, `Positrons`.

Available `primary_channel` are: 
- `eL`, `eR`, `e`,
- `muL`, `muR`, `mu`,
- `tauL`, `tauR`, `tau`,
- `nu_e`, `nu_mu`, `nu_tau`,
- `u`, `d`, `s`, `c`, `b`, `t`,
- `a`, `g`,
- `W`, `WL`, `WT`,
- `Z`, `ZL`, `ZT`,
- `H`,
- `aZ`,
- `HZ`

### Example

```julia
using CosmiXs
using Unitful

mDM = 100u"GeV"
K = 1u"GeV"

dNdE(mDM, K, final_particles="Gammas", primary_channel="b")
```


