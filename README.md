## Sky130 PDK for Cedar

<a href="https://help.juliahub.com/sky130/dev/"><img src='https://img.shields.io/badge/docs-dev-blue.svg'/></a>

This package redistributes the Skywater 130nm PDK (as distributed by https://github.com/RTimothyEdwards/open_pdks) for use with Cedar.

## Usage

When CedarSim reads the netlist and sees a file path for an `.include` or `.lib` file
with a `jlpkg://Sky130PDK` prefix it will reference the `Sky130PDK` model files via
the Julia package mechanism.  Modify your netlist like so:

```
.lib jlpkg://Sky130PDK/sky130A/libs.tech/ngspice/sky130.lib.spice tt
```
