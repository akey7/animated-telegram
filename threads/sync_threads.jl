# Number of threads to use
n_threads = 4

# Array to store thread tasks
tasks = Vector{Task}(undef, n_threads)

# Launch tasks on separate threads
for i in 1:n_threads
    tasks[i] = Threads.@spawn begin
        # Your task code here
        println("Task $i is running on thread $(Threads.threadid()).")
        sleep(rand())  # Simulate some work with random sleep
        println("Task $i is done.")
    end
end

# Wait for all tasks to complete
for task in tasks
    Threads.wait(task)
end

println("All tasks are finished.")
