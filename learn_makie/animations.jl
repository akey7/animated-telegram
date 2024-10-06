# https://docs.makie.org/stable/explanations/animation

using GLMakie
using Makie.Colors

# fig, ax, lineplot = lines(0..10, sin; linewidth=10)
# nframes = 30
# framerate = 30
# hue_iterator = range(0, 360, length=nframes)

# record(fig, "color_animation.mp4", hue_iterator; framerate=framerate) do hue
#     lineplot.color = HSV(hue, 1, 0.75)
# end

time = Observable(0.0)

xs = range(0, 7, length=40)

ys_1 = @lift(sin.(xs .- $time))
ys_2 = @lift(cos.(xs .- $time) .+ 3)

fig = lines(xs, ys_1, color = :blue, linewidth = 4,
    axis = (title = @lift("t = $(round($time, digits = 1))"),))
scatter!(xs, ys_2, color = :red, markersize = 15)

framerate = 30
timestamps = range(0, 2, step=1/framerate)

record(fig, "time_animation.mp4", timestamps;
        framerate = framerate) do t
    time[] = t
end
