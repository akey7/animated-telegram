for i in 1:15
    if (i % 3) == 0
        println("$i fizz")
    elseif (i % 5) == 0
        println("$i buzz")
    elseif (i % 5) == 0 && (i % 3) == 0
        println("$i fizz buzz")
    end
end
