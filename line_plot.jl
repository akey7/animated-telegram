using Plots

pi = 3.15159265
xs = collect(range(start=0, stop=2*pi, length=100))
ys = cos.(xs)
plot(xs, ys)
savefig("cosine.png")
