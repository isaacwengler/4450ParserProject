# this file is for testing
# this contains multiple sorting algorithms what should be parsed correctly

def bubble_sort(arr):
    length = len(arr)
 
    # Traverse through all array elements
    for i in range(length):
 
        # Last i elements are already in place
        for j in range(0, length - i - 1 ):
            # bubble up, swapping if greater
            if arr[j] > arr[j+1]:
                temp = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = temp
 
    return arr


# this code is from geeks for geeks, just to test the parser with any python code
def merge(arr, start, mid, end):
    start2 = mid + 1
  
    # If the direct merge is already sorted
    if (arr[mid] <= arr[start2]):
        return
  
    # Two pointers to maintain start
    # of both arrays to merge
    while (start <= mid and start2 <= end):
# this comment is in weird spot but should not mess everything up
        # If element 1 is in right place
        if (arr[start] <= arr[start2]):
            start += 1
        else:
            value = arr[start2]
            index = start2
  
            # Shift all the elements between element 1
            # element 2, right by 1.
            while (index != start):
                arr[index] = arr[index - 1]
                index -= 1
  
            arr[start] = value
  
            # Update all the pointers
            start += 1
            mid += 1
            start2 += 1

def mergeSort(arr, l, r):
    if (l < r):
  
        # Same as (l + r) / 2, but avoids overflow
        # for large l and r
        m = l + (r - l) // 2
  
        # Sort first and second halves
        mergeSort(arr, l, m)
        mergeSort(arr, m + 1, r)
  
        merge(arr, l, m, r)


my_array = [1, 4**2, 3 + 3 - 10, 6, -234]
my_tuple = (my_array, [1, 2, 5, 3, 5 ** 2, "hello", "hello " + "world"], 15)

# trying out all of our sorting algorithms
my_array.sort()
my_array = bubble_sort(my_array)

# # uncomment this to see an error
# # because you cannot "return" outside a function
# for num in my_array:
#     if num > 5:
#         return num
