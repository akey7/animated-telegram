using GLMakie

# Generate some random data
x = rand(100)
y = rand(100)
z = rand(100)

# Create a 3D scatter plot
scene = scatter(x, y, z)

# Display the plot
display(scene)
readline()
