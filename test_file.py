def minDistance(self, word1, word2):
    memo = numpy.zeros((len(word1)+1,len(word2)+1))
    # Init for null row and word2
    for col in range(len(memo[0])):
        memo[0][col] = col
    # Init for null col and word1
    for row in range(len(memo)):
        memo[row][0] = row
    
    # Now we will use previously stored values
    for row in range(1, len(memo)):
        for col in range(1, len(memo[0])):
            # If chars are not same then we don't need any opeartion, so we just check for value without those chars of below condition
            # To get idea lets consider abcde bcd
            # when d == d then we need to check for (abc bc)
            if word1[row - 1] == word2[col - 1]:
                memo[row][col] = memo[row - 1][col - 1]
            # If chars are not same then its just either of the operation 1 + min((abc,bc),(abcd,bc),(abc,bcd))
            else:
                memo[row][col] = 1+ min(memo[row - 1][col],memo[row][col - 1],memo[row - 1][col - 1])
    
    return int(memo[-1][-1])

var1 = "hello"
var2 = "hola"
print(minDistance(var1, var2))

"".split(var1)
splitVar1 = "".split(var1)
[1, 5, 3, 4].sort()
sorted = [1, 5, 3, 4].sort()

# uncomment this to produce an error, since you cannot return in a while loop
# while len(var1) > len(var2):
#     if (minDistance(var1, var2) > 5):
#         var1 = var1[0]
#     else:
#         return False
