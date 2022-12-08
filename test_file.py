my_var = 100 # comment here huh
my_other_var = 123.432

# my var is int
if my_var > 100:
    my_new_var = 12
    # indented comment
    is_good = True
# this comment is weird but should not mess up indents          
    complex = 29383 / 12 + (122 - 34)    

    # more comment
    if 1 == my_new_var and 5 - 10 > my_var or (complex or is_good): # comment here
        my_new_var = my_other_var
    elif is_good:
        is_good = not is_good
elif (my_var + 100) >= 12:
    hello = "hello"
elif my_other_var == True:
    complex2 = 100
    complex2 **= 10
else:
    #this is inside the else               
    my_var = False
    empty_var = None

my_array = [1, "hello", 3 * 100, [1, 2, 3]]
my_tuple =  (1, "hello", 3 * 100, [1, 2, 3])

is_in_the_array = False

for var in [1, 2, 3, 4, 5, 6]: # comment here is weird
    # another
    while var >= 1:
        if var == my_var:
            # commmmmmmment
            is_in_the_array = False
#unindented
            continue
        else:
            var -= 1
