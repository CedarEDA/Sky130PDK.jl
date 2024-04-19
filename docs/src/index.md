# Sky130PDK.jl

The purpose of this package is to make it extremely easy to include the Sky130PDK by use of the 
Julia package manager which allows for simple installation, compatible version resolution and updating.

## PDK Contents
This Sky130PDK originally came from the Google/Skywater collaboration ([here](https://skywater-pdk.readthedocs.io/en/main/)) and has been updated with fixes 
from various groups.  The continuous (non-binned) models have been added for device models (except for RF).
If there are issues then please [open an Issue](https://github.com/JuliaComputing/Sky130PDK.jl/issues).

## Usage
### 1. Netlist Usage

When CedarSim reads the netlist and sees a file path for an `.include` or `.lib` file 
with a `jlpkg://Sky130PDK` prefix it will reference the `Sky130PDK` model files via 
the Julia package mechanism.  Modify your netlist like so:

```
.lib jlpkg://Sky130PDK/sky130A/libs.tech/ngspice/sky130.lib.spice tt
```

### 2. Top-level Julia Script
Then in your Julia script that runs the simulation, ensure to load the `Sky130PDK` package as well as `CedarEDA`.
If the Julia package manager asks you to install the package then answer `y`.

```julia
julia> using Sky130PDK
 │ Package Sky130PDK not found, but a package named Sky130PDK is available
 │ from a registry. 
 │ Install package?
 │   (@v1.11) pkg> add Sky130PDK 
 └ (y/n/o) [y]: y
julia> using CedarEDA
```

Now to run a simulation with the PDK load `CedarEDA` create a script like so:

```
using CedarEDA
using CedarWaves
using Sky130PDK

sm = SimManager("top.spice") # read netlist with .param cload and rload
# Setup 3x3=9 point parameter sweep
params = ProductSweep(
  cload=[10e-12, 20e-12, 50e-12],
  rload=[1000, 10e3, 20e3],
)
sp = SimParameterization(params=params, tspan=(0, 20-e6)) # parameterize netlist
tran1 = tran!(sp) # run transient
inspect(tran1.tran.node_vout) # plot signals

p2p = peak2peak.(tran1.tran.node_vout) # measure P2P voltage of Vout across 9 point sweep
```

The above will run a 2D parameter sweep and make a `peak2peak` measurement of the `vout` node
for each sweep point.

## Version Control
Since `Sky130PDK` is a regular Julia package it has version numbers and users can specify which
version of the PDK is compatible with their project or simulator. See the 
[Managing Documentation](https://pkgdocs.julialang.org/v1/managing-packages/) in the 
Pkg [manual](https://pkgdocs.julialang.org/v1/) for more info.
