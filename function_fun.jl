getSum(x, y) = x + y

println(getSum(5, 3))

function canIVote(age=16)
    if age > 18
        println("You can vote")
    else
        println("You cannot vote")
    end
end

canIVote(20)
canIVote(12)

function getSum2(args...)
    sum = 0
    for a in args
        sum += a
    end
    return sum
end

println(getSum2(1,2,3))


