# sensivity
#M1

function rep_num1(PP)
    β, l, β′, β´´, κ, ρ₁,	ρ₂,	γₐ,	γᵢ,	γᵣ,	δᵢ,	δₚ, δₕ, δₐ=PP
    ωh=γᵣ+δₕ
    ωp=γₐ+γᵢ+δₚ
    ωi=γₐ+γᵢ+δᵢ
 R = β*ρ₁*(γₐ *l + ωh)/(ωh*ωi) + ρ₂*(β*γₐ*l + β′ * ωh)/(ωh*ωp)
 return R
end
par1= [3.7867885928014893, 2.282972432258884, 0.9407139791767547, 6.767816564146801, 0.11784770556372894, 0.6251069517622732, 0.001, 0.15459463331892578, 0.6976487340139972, 0.001310080700085496, 0.03059906827360447, 0.9999999997068166, 0.039772994593994866, 0.0025773545913321608]
par1f8=[3.7867885928014893, 2.282972432258884, 0.9407139791767547, 6.767816564146801, 0.11784770556372894, 0.6611967577882444, 0.001, 0.15459463331892578, 0.6976487340139972, 0.001310080700085496, 1.0000000000000003e-5, 1.0000000000025588e-5, 0.07032489285794451, 0.0025773545913321608]
PAR1=hcat(par1,par1f8)

R01=zeros(size(PAR1))

for j=1:2
    Arg=PAR1[:,j]
        for i in 1:14
            Arg1=copy(Arg)
            Arg1[i]=Arg[i]+0.01
            R01[i,j]=(rep_num1(Arg1)-rep_num1(Arg))*Arg[i]/(rep_num1(Arg)*0.01)
        end
end

## M2

function rep_num2(PP)
    β, l, β′, β´´, κ, ρ₁,	ρ₂,	γₐ,	γᵢ,	γᵣ,	δᵢ,	δₚ, δₕ, δₐ=PP
    ωh=γᵣ+δₕ
    ωp=γₐ+γᵢ+δₚ
    ωi=γₐ+γᵢ+δᵢ
 R = β*ρ₁*(γₐ *l + ωh)/(ωh*ωi) + ρ₂*(β*γₐ*l + β′ * ωh)/(ωh*ωp) + β´´*(1-ρ₁-ρ₂)/(δₐ)
 return R
end

par2=[3.7867885928014893, 2.282972432258884, 0.9407139791767547, 9.999999999999961, 0.11784770556372894, 0.5854858708174663, 0.001, 0.15459463331892578, 0.6976487340139972, 0.001310080700085496, 1.0000000000000472e-5, 0.9999999999999993, 0.03665083895773696, 0.0024880418173123466]
par2f8=[3.7867885928014893, 2.282972432258884, 0.9407139791767547, 9.999999999999522, 0.11784770556372894, 0.6010653383022428, 0.001, 0.15459463331892578, 0.6976487340139972, 0.001310080700085496, 1.0000000000000006e-5, 1.0000000000304157e-5, 0.04586890816415926, 0.0015499964449613957]

PAR2=hcat(par2,par2f8)

R02=zeros(size(PAR2))

for j=1:2
    Arg=PAR2[:,j]
        for i in 1:14
            Arg1=copy(Arg)
            Arg1[i]=Arg[i]+0.01
            R02[i,j]=(rep_num2(Arg1)-rep_num2(Arg))*Arg[i]/(rep_num2(Arg)*0.01)
        end
end

function myshowall(io, x, limit = false)
  println(io, summary(x), ":")
  Base.print_matrix(IOContext(io, :limit => limit), x)
end

myshowall(stdout, R01, false)
myshowall(stdout, R02, false)
features=hcat(R01,R02)

using DataFrames
parameters=["β", "l", "β′", "β´´", "κ", "ρ₁",	"ρ₂",	"γₐ",	"γᵢ",	"γᵣ",	"δᵢ",	"δₚ", "δₕ", "δₐ"]

df=DataFrame(Parameters=parameters, M1=features[:,1], FM1=features[:,2],M2=features[:,3], FM2=features[:,4])

show(IOContext(stdout, :limit=>false), df)
