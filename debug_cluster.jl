using Pkg
Pkg.activate(joinpath(@__DIR__))

##
using InteractiveUtils
versioninfo()

##
if(length(ARGS) < 1)
    using LinearAlgebra
else
    using MKL
    using LinearAlgebra
end
println()
println("BLAS:")
println("  num_threads: ", BLAS.get_num_threads())
println("  config: ", BLAS.get_config())

##
using OrdinaryDiffEq
using BenchmarkTools

io = IOContext(stdout)

##
println("-------------------------------------------------------------------------")

##
#number of ODE equations
N1 = 99
println()
println("Number of ODE equations: ", N1)

#simple ODE problem (https://de.mathworks.com/company/newsletters/articles/stiff-differential-equations.html)
u1 = zeros(N1)
du1 = zeros(N1)

delta1 = 0.002
sim_time1 = 2.0/delta1

u1 = u1 .+ delta1

function foo1(du1, u1, p, t)
    for i in 1:N1
        du1[i] = (u1[i]^2 - u1[i]^3)
    end
end

##
prob1 = ODEProblem(foo1, u1, (0.0, sim_time1), nothing)
println()

##
#check how long the solver needs
bm1 = @benchmark solve(prob1, Rodas4())

##
#show benchmark result
show(io, MIME("text/plain"), bm1)
println()

##
println("-------------------------------------------------------------------------")

##
#number of ODE equations
N2 = 100
println()
println("Number of ODE equations: ", N2)

#simple ODE problem (https://de.mathworks.com/company/newsletters/articles/stiff-differential-equations.html)
u2 = zeros(N2)
du2 = zeros(N2)

delta2 = 0.002
sim_time2 = 2.0/delta2

u2 = u2 .+ delta2

function foo2(du2, u2, p, t)
    for i in 1:N2
        du2[i] = (u2[i]^2 - u2[i]^3)
    end
end

##
prob2 = ODEProblem(foo2, u2, (0.0, sim_time2), nothing)
println()

##
#check how long the solver needs
bm2= @benchmark solve(prob2, Rodas4())

##
#show benchmark result
show(io, MIME("text/plain"), bm2)
println()
