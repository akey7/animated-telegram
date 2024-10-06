# Following https://docs.makie.org/stable/tutorials/aspect-tutorial

using CairoMakie
set_theme!(backgroundcolor = :gray90)

f = Figure(size = (800, 500))
ax = Axis(f[1, 1], aspect = 1)
Colorbar(f[1, 2])
colsize!(f.layout, 1, Aspect(1, 1.0))
Box(f[1, 1], color = (:red, 0.2), strokewidth = 0)
resize_to_layout!(f)
save("learn_makie.png", f)
