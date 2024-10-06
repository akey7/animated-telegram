using CairoMakie

seconds = 0:0.1:2
measurements = [8.2, 8.4, 6.3, 9.5, 9.1, 10.5, 8.6, 8.2, 10.5, 8.5, 7.2, 8.8, 9.7, 10.8, 12.5, 11.6, 12.1, 12.1, 15.1, 14.7, 13.1]

# Create a simple scatter plot
fig = Figure()
ax = Axis(fig[1, 1])
lines!(ax, 1:10, rand(10))

# Display the plot
display(fig)
