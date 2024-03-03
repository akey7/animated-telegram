using Distributions
using Plots

# Create a normal distribution object
dist = Normal(0, 1)  # μ is the mean, σ is the standard deviation

# Draw multiple random values from the distribution
random_values = rand(dist, 1000)  # n is the number of values you want to generate

# Create and customize the histogram
hist = histogram(random_values, bins=100, title="Normally Distributed Random Values", xlabel="Values", ylabel="Frequency", legend=false)

# Optionally, save the plot to a file
display(hist)
readline()
