using GLMakie

# Define the two-dimensional Gaussian function
function gaussian(x, y; μx = 0.0, μy = 0.0, σx = 1.0, σy = 1.0)
    return exp(-((x - μx)^2 / (2 * σx^2) + (y - μy)^2 / (2 * σy^2)))
end

# Create a grid of points in the x-y plane
x = LinRange(-3, 3, 100)
y = LinRange(-3, 3, 100)
z = [gaussian(xi, yi) for xi in x, yi in y]

# Create the surface plot
fig = Figure()
ax = Axis3(fig[1, 1], xlabel = "x", ylabel = "y", zlabel = "z", title = "2D Gaussian Surface Plot")
surface!(ax, x, y, z, colormap = :viridis)

# Display the plot
display(fig)

# Wait for user input to exit
readline()
