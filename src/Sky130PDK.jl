module Sky130PDK

module sky130lib
    using CedarSim
    using BSIM4

    path = joinpath(@__DIR__, "../sky130A/libs.tech/ngspice/sky130.lib.spice")
    eval(CedarSim.load_spice_modules(path;
        pdk_include_paths=[dirname(path)],
        names=["tt", #="ff", "ss", "fs", "sf"=#],
        preload=[CedarSim, CedarSim.SpectreEnvironment, BSIM4],
    ))
end

const files = Dict{String,  Module}(
    "sky130.lib.spice" => sky130lib
)

function get_module(name::String)
    try
        return files[name]
    catch
        throw(ArgumentError("File \"$name\" not found in $(keys(files))"))
    end
end

using PrecompileTools
using CedarSim
using .sky130lib.tt
@setup_workload begin
    (;d, g, s, b) = nets()
    🔍 = CedarSim.ParamLens()
    @compile_workload begin
        Base.with(CedarSim.spec=>CedarSim.SimSpec(scale=1e-6)) do
            sky130lib.tt.@ckt_sky130_fd_pr__nfet_01v8(nodes=(g, d, s, b), w=1, l=1)
            sky130lib.tt.@ckt_sky130_fd_pr__pfet_01v8(nodes=(g, d, s, b), w=1, l=1)
            #TODO add more devices, but these are currently all we seem to use
        end
    end
end

end
