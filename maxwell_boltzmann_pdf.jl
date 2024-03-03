using Plots

function maxwell_boltzmann_pdf(velocities, sigma)
    function mb_pdf(v)
        sqrt(2 / π) * (v^2 * exp(-v^2 / (2 * sigma^2))) / sigma^3
    end

    mb_pdf.(velocities)
end

velocities = collect(range(start=0, stop=2000, length=100))
pdf = maxwell_boltzmann_pdf(velocities, 300)

display(plot(velocities, pdf))
readline()
